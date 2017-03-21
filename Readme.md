# Chef and Test Kitchen sample repo

Test a sample chef recipe on multiple Docker container via `test-kitchen` and
`kitchen-docker`.

## Prerequisites

1. Ruby

    Currently configured to use `2.4.0`, though other versions might work as
    well. You can use [rvm](https://rvm.io/) to install custom Ruby versions on
    macOS.

    ```shell
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable
    rvm use 2.4.0 --install
    ```

1. Docker

    You need to have [Docker](https://www.docker.com/) installed on your
    computer. To install it on your Mac, please download Docker CE for Mac
    from the [Docker Store](https://store.docker.com/editions/community/docker-ce-desktop-mac)

## Running locally

```shell
git clone https://github.com/mlocher/sample-chef-kitchen-docker.git
bundle install
kitchen test
```

## Running via Codeship's "jet" CLI

This repository also contains configuration files for [Codeship Pro](https://codeship.com/features/pro).

Those files are the `codeship-services.yml`, defining which services are
required to run the tests on Codeship, the `codeship-steps.yml` defining the
individual steps to run and a `Dockerfile` to build the main image to run those
tests on.

To use the `kitchen-docker` driver, the main image makes use of "Docker in
Docker", making the Docker daemon available inside a Docker container.

Unfortunately, because of this special setup, Test Kitchen, doesn't connect to
the correct host when trying to access the containers via SSH and the tests hang
with the following log output

```shell
Waiting for SSH service on localhost:32779, retrying in 3 seconds
...
```

The mentioned port is exposed on the main Docker host and forwards traffic to
port `22` on the container.

If you want to give this a try, [install the "jet" CLI](https://documentation.codeship.com/pro/getting-started/installation/)
on your local computer and the run the following command from the root of this
repository.

```shell
jet steps
```
