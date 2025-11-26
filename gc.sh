#!/bin/bash

# Colors
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${BLUE}🔍 Adding all changes...${RESET}"
git add .

echo -e "${BLUE}🔍 Displaying current changes ${RESET}"
git status

echo -ne "${YELLOW}💬 Enter commit message: ${RESET}"
read msg

if [ -z "$msg" ]; then
    echo -e "${RED}❌ Commit message cannot be empty!${RESET}"
    exit 1
fi

if [ -f "package.json" ]; then
    echo -e "${YELLOW}📦 Package.json detected. Update version?${RESET}"
    echo -e "${BLUE}1) Major (x.0.0) - Breaking changes${RESET}"
    echo -e "${BLUE}2) Minor (0.x.0) - New features${RESET}"
    echo -e "${BLUE}3) Patch (0.0.x) - Bug fixes${RESET}"
    echo -e "${BLUE}4) Skip version update${RESET}"
    echo -ne "${YELLOW}💬 Choose option (1-4): ${RESET}"
    read version_choice

    case $version_choice in
        1)
            npm version major --no-git-tag-version
            version_type="major"
            ;;
        2)
            npm version minor --no-git-tag-version
            version_type="minor"
            ;;
        3)
            npm version patch --no-git-tag-version
            version_type="patch"
            ;;
        4)
            echo -e "${YELLOW}⏭️  Skipping version update${RESET}"
            version_type="skip"
            ;;
        *)
            echo -e "${RED}❌ Invalid choice, skipping version update${RESET}"
            version_type="skip"
            ;;
    esac

    if [ "$version_type" != "skip" ]; then
        new_version=$(node -p "require('./package.json').version")
        echo -e "${GREEN}✅ Updated to version: $new_version${RESET}"
        git add package.json
    fi
else
    echo -e "${YELLOW}📦 No package.json found, skipping version update${RESET}"
fi

echo -e "${BLUE}📝 Committing changes...${RESET}"
git commit -m "$msg"

echo -e "${GREEN}🚀 Pushing to remote...${RESET}"
git push

echo -e "${GREEN}✅ Done!${RESET}"