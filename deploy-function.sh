#!/bin/bash

set -eu

for arg in "$@"; do
    case $arg in
    --firebase-token=*)
        FIREBASE_TOKEN="${arg#*=}"
        ;;
    --project-name=*)
        PROJECT_NAME="${arg#*=}"
        ;;
    --resources-name=*)
        RESOURCES_NAME="${arg#*=}"
        ;;
    esac
    shift
done

showValidation() {
    echo "Make sure you are passing all required parameters:
        deploy-site.sh \\
            --firebase-token=(required) \\
            --resources-name=(required) \\
            --project-name=(required)
        
        You currently passed:
        --firebase-token: $FIREBASE_TOKEN
        --resources-name: $RESOURCES_NAME
        --project-name: $PROJECT_NAME
    " 1>&2

    exit 1
}

# Validate params
if [ -z "$FIREBASE_TOKEN" ] || [ -z "$RESOURCES_NAME" ] || [ -z "$PROJECT_NAME" ]; then
    showValidation
fi

# Install packages
npm ci
sed -i -e "s#PROJECT#$PROJECT_NAME#g" ./.firebaserc
# Create a target
./node_modules/.bin/firebase functions:config:get --project $PROJECT_NAME --token="$FIREBASE_TOKEN"
echo "#### Deploying function in $PROJECT_NAME project ####"
# Deploy site in firebase
./node_modules/.bin/firebase deploy --token="$FIREBASE_TOKEN" --project $PROJECT_NAME --only functions
echo "Firebase function deploy !"