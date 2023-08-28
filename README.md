# ham-dht-tools Docker Image

This Ubuntu Linux based Docker image allows you to run [N7TAE's](https://github.com/n7tae) [ham-dht-tools](https://github.com/n7tae/ham-dht-tools) without having to compile any code.

This is a currently a single-arch image and will only run on amd64 devices.

| Image Tag             | Architectures           | Base Image         | 
| :-------------------- | :-----------------------| :----------------- | 
| latest, ubuntu        | amd64                   | Ubuntu 22.04       | 

## Usage

Command Line:

```bash
docker run -it mfiscus/ham-dht-tools dht-get
docker run -it mfiscus/ham-dht-tools dht-spider
docker run -w /usr/local/bin -it mfiscus/ham-dht-tools get-config-params
```

Using [.bash_aliases](https://www.gnu.org/software/bash/manual/html_node/Aliases.html) (recommended):

```bash
alias dht-get="docker run -it mfiscus/ham-dht-tools dht-get"
alias dht-spider="docker run -it mfiscus/ham-dht-tools dht-spider"
alias get-config-params="docker run -w /usr/local/bin -it mfiscus/ham-dht-tools get-config-params"
```

## License

Copyright (C) 2020-2022 Thomas A. Early N7TAE  
Copyright (C) 2023 Matt Fiscus KK7MNZ

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the [GNU General Public License](./LICENSE) for more details.
