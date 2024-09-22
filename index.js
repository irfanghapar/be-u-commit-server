const fs = require('fs').promises;
const path = require('path');
const moment = require('moment');
const simpleGit = require('simple-git');

const projectStructure = {
    'src': {
        'controllers': ['userController.js', 'authController.js', 'dataController.js'],
        'models': ['userModel.js', 'dataModel.js'],
        'routes': ['userRoutes.js', 'authRoutes.js', 'dataRoutes.js'],
        'middleware': ['authMiddleware.js', 'errorMiddleware.js'],
        'utils': ['logger.js', 'database.js', 'validation.js']
    },
    'config': ['database.js', 'server.js'],
    'tests': ['userTests.js', 'authTests.js', 'dataTests.js']
};

const commitMessages = [
    "Update API endpoints in {file}",
    "Optimize database queries in {file}",
    "Implement new authentication system",
    "Refactor {file} for better performance",
    "Add caching layer to {file}",
    "Improve error handling in {file}",
    "Update dependencies and adjust {file}",
    "Implement new feature: user profiles",
    "Fix security vulnerability in {file}",
    "Optimize server performance",
    "Add logging system",
    "Implement data backup solution",
    "Update documentation for {file}",
    "Implement rate limiting in {file}",
    "Add unit tests for {file}"
];

const getRandomFile = () => {
    const folders = Object.keys(projectStructure);
    const randomFolder = folders[Math.floor(Math.random() * folders.length)];
    if (Array.isArray(projectStructure[randomFolder])) {
        return path.join(randomFolder, projectStructure[randomFolder][Math.floor(Math.random() * projectStructure[randomFolder].length)]);
    } else {
        const subfolders = Object.keys(projectStructure[randomFolder]);
        const randomSubfolder = subfolders[Math.floor(Math.random() * subfolders.length)];
        return path.join(randomFolder, randomSubfolder, projectStructure[randomFolder][randomSubfolder][Math.floor(Math.random() * projectStructure[randomFolder][randomSubfolder].length)]);
    }
};

const getRandomCommitMessage = (file) => {
    const message = commitMessages[Math.floor(Math.random() * commitMessages.length)];
    return message.replace('{file}', file);
};

const modifyFile = async (filePath) => {
    const content = `// Last modified: ${new Date().toISOString()}\n// TODO: Implement functionality\n`;
    await fs.writeFile(filePath, content, { flag: 'a' });
};

const makeCommits = async () => {
    const git = simpleGit();
    const startDate = moment('2024-01-01');
    const endDate = moment('2024-12-31');
    const totalDays = endDate.diff(startDate, 'days') + 1;
    const commitDays = Math.floor(totalDays * 0.5); // Commit on roughly 50% of days

    // Create initial project structure
    for (const [folder, contents] of Object.entries(projectStructure)) {
        await fs.mkdir(folder, { recursive: true });
        if (Array.isArray(contents)) {
            for (const file of contents) {
                await fs.writeFile(path.join(folder, file), '// Initial commit\n');
            }
        } else {
            for (const [subfolder, files] of Object.entries(contents)) {
                await fs.mkdir(path.join(folder, subfolder), { recursive: true });
                for (const file of files) {
                    await fs.writeFile(path.join(folder, subfolder, file), '// Initial commit\n');
                }
            }
        }
    }

    // Make initial commit
    await git.add('.');
    await git.commit('Initial project structure');

    for (let i = 0; i < commitDays; i++) {
        const randomDay = startDate.clone().add(Math.floor(Math.random() * totalDays), 'days');
        const numCommits = Math.floor(Math.random() * 5) + 1; // 1 to 5 commits per day
        
        for (let j = 0; j < numCommits; j++) {
            const DATE = randomDay.format();
            const file = getRandomFile();
            const commitMessage = getRandomCommitMessage(file);
            
            await modifyFile(file);
            console.log(`Committing for ${DATE}: ${commitMessage}`);
            await git.add('.');
            await git.commit(commitMessage, {'--date': DATE});
        }
    }
    
    console.log('All commits created. Pushing to remote...');
    await git.push();
    console.log('Push completed.');
};

makeCommits().catch(console.error);
