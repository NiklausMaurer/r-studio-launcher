# r-studio-launcher
Tiny helper script to launch r-studio in a docker container.

The script is implemented in a way that allows mulitple instances to run in parallel. The current version attaches the terminal to the container after launching the browser. This way the container can be terminated easily by pressing `Crtl+C` in the respective terminal.

**_Attention:_** R-Studio will be run with `AUTHENTICATION_DISABLED=true`. To mitigate security risks, the container will only listen to the loopback interface `127.0.0.1` by default.

## Setting up
Make sure you have Docker installed and set up (refer to https://docs.docker.com/get-docker/).

Copy the script to wherever you want. In case you download it don't forget to add execution permissions
```console
chmod +x rstudio
```

## Usage
```console
rstudio [directory]
```

The given directory will be mapped into the container. If no directory is provided, the current working directory will be mapped.
