import { writeFileSync, readdirSync, readFileSync } from 'node:fs';
import { join } from 'node:path';

let text = `# 🍀Cloud Wave Group Project - Olive Safety

This code was reconstructed based on the content of the Cloud Wave group project. 

Group Project: https://github.com/5a6io/OliveSafety.git

I haven't original code. So, it may be different from that.

I wrote the code by service.

## 🌟Terraform Code

`;

(async () => {
    try {
        const tfFiles = readdirSync('./').filter(file => file.endsWith('.tf'));

        for (const file of tfFiles) {
            const content = readFileSync(join('./', file), 'utf-8');
            text += `### ⌨️${file}\n\`\`\`hcl\n${content}\n\`\`\`\n\n`;
        }

        writeFileSync('README.md', text);
        console.log('README.md updated');
    } catch(error){
        console.error("다음과 같은 오류 발생:", error);
    }
})