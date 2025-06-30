import { writeFileSync, readdirSync, readFileSync, statSync } from 'node:fs';
import { join } from 'node:path';

let text = `# 🍀Cloud Wave Group Project - Olive Safety

This code was reconstructed based on the content of the Cloud Wave group project. 

Group Project: https://github.com/5a6io/OliveSafety.git

I haven't original code. So, it may be different from that.

I wrote the code by service.

## 🌟Terraform Code

`;

const priorityFiles = ['main.tf', 'network.tf'];

(async () => {
    try {
        const allTfFiles = readdirSync('./')
            .filter(file => file.endsWith('.tf'));

        const tfFiles = [...priorityFiles.filter(file => allTfFiles.includes(file)),
            ...allTfFiles
                .filter(file => !priorityFiles.includes(file))
                .sort()
        ];

        for (const file of tfFiles) {
            const content = readFileSync(join('./', file), 'utf-8');
            text += `### ⌨️${file}\n\`\`\`hcl\n${content}\n\`\`\`\n\n`;
        }

        writeFileSync('README.md', text);
        console.log(`${text}`);
        console.log('README.md updated');
    } catch(error){
        console.error("다음과 같은 오류 발생:", error);
    }
})();