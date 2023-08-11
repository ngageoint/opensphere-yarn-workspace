# OpenSphere Yarn Workspace

This project facilitates linking related OpenSphere projects (OpenSphere, plugins, configuration) with [Yarn workspaces](https://yarnpkg.com/lang/en/docs/workspaces/).

## Setup

* [Install Yarn](https://yarnpkg.com/en/docs/install).
* Clone this project.
* Clone any projects/dependencies under development to the `workspace` directory. All `workspace` subfolders will be linked appropriately in `node_modules` by `yarn install`. At minimum, clone a fork of [OpenSphere](https://github.com/ngageoint/opensphere).

Any directories prefixed with `opensphere-plugin-` or `opensphere-config-` will be detected by the [OpenSphere resolver](https://github.com/ngageoint/opensphere-build-resolver) as plugin/config projects and included in the OpenSphere build.

## Yarn Install

After cloning all projects, run `yarn install`. Running this from any directory will update links/dependencies for the entire workspace.

## Staging Area

The `staging` folder can be used to clone projects you may not always want to include in the OpenSphere build. For example, if you regularly swap out plugins or configuration you can clone them to `staging` and symlink them to `workspace` when needed. They will only be linked by Yarn and detected by the OpenSphere resolver when symlinked to `workspace`. Always run `yarn install` after changing these links to ensure the workspace is set up correctly.

## Local Development

1. Recommend using `nvm install 16` and `nvm use 16`
1. `cd` into `/workspace/opensphere`
1. Run `yarn install`
1. Run `yarn build`
1. Run `yarn run test`

If any step fails, troubleshoot and update these docs.