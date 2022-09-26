# r-studio-launcher
Tiny helper script to launch r-studio in a docker container

## Setting up
Just copy the script to wherever you want. In case you download it don't forget to add execution permissions
```console
chmod +x rstudio
```

## Usage
```console
rstudio [directory]
```

The given directory will be mapped into the container. If no directory is provided, the current working directory will be mapped.
