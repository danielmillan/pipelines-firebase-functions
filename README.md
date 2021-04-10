# Pipeline Firebase Functions

This action is built with a continuous deployment approach, allowing to deploy a backend or function on firebase functions.

## Sample implementation

To configure in your repository this action, it is necessary to have a PTA and use actions/checkout@v2 action, the following way shows an example:

```sh
- name: Checkout danielmillan/pipelines-firebase-functions
        uses: actions/checkout@v2
        with:
          repository: danielmillan/pipelines-firebase-functions
          ref: '1.0.2'
          token: ${{ secrets.CA_GITHUB_TOKEN }}
          persist-credentials: false
          path: ./.github/actions/pipelines-firebase-functions
```

> Note: the variable `CA_GITHUB_TOKEN`, it should contain the respective token from your repository secrets, for more information visit: https://docs.github.com/en/actions/reference/authentication-in-a-workflow

## Parameters

Please note the following parameters to configure the action:

```sh
firebase-token:
    description: Token generated to authenticate in firebase
    required: true
  resources-name:
    description: Name of the folder containing the resources to be deployed
    required: true
  project-name:
    description: Firebase project name
    required: true
```

## Job

```sh
- name: Deploy function
```
