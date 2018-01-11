This is the staging area for plugins/configuration that are often swapped in and out of the Opensphere build. Projects cloned to this directory will not be linked by yarn or detected by the OpenSphere resolver unless symlinked to the `workspace` directory.

To add a project from staging to the OpenSphere build, create a symlink to it in `workspace` and run `yarn install` to update links/dependencies in `node_modules`.
