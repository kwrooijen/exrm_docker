# ExrmDocker

Create a Docker image from your Elixir release

## Usage

To create a new Docker image simply run:

- `mix release --docker`

This will output the `docker build` result with the created image id.

Once your image has been built, start a new container.

- `docker run -itd <image_id> console`

Next you can attach to your container.

- `docker attach <container_id>`

And detach using `Ctrl-p Ctrl-q`.


Check below for configuration options.

## Installation
#### Add exrm_docker to your list of dependencies in `mix.exs`:

        def deps do
          [{:exrm_docker, "~> 0.0.2"}]
        end


## exrm_docker config.exs

 Key        | Default                                      | Description
----------- | -------------------------------------------- | -----------------------------------
 image      | centos                                       | Which image to use
 version    | nil                                          | Which image version to use
 maintainer | nil                                          | Image maintainer
 copy_rel   | COPY rel /rel                                | Copy the release to the container
 pre_copy   | nil                                          | Any Dockerfile commands before copy
 post_copy  | nil                                          | Any Dockerfile commands after copy
 entrypoint | ENTRYPOINT ["rel/#{project}/bin/#{project}"] | Entrypoint of the image
