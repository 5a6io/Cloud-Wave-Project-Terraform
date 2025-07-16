import { writeFileSync } from 'node:fs';
import dotenv from 'dotenv';

dotenv.config();

let text = `# 🍀Cloud Wave Group Project - Olive Safety

This code was reconstructed based on the content of the Cloud Wave group project. 

Group Project: https://github.com/5a6io/OliveSafety.git

I haven't original code. So, it may be different from that.

It was written separately by modules and environments.

## 🗂️Directory Structure

`;

const tree = process.env.TREE_OUTPUT;

if (!tree) {
    console.error('TREE_OUTPUT 환경변수가 설정되지 않음.');
    exit(1);
}

(async () => {
    try {

        text += `\`\`\`bash\n${tree}\n\`\`\`\n`

        writeFileSync('README.md', text);
        console.log(`${text}`);
        console.log('README.md updated');
    } catch(error){
        console.error("다음과 같은 오류 발생:", error);
    }
})();