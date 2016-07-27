defmodule ExrmDockerTest do
  use ExUnit.Case
  doctest ReleaseManager.Plugin.ExrmDocker

  @default image: "centos",
           version: nil,
           maintainer: nil,
           copy_rel: "COPY rel /rel",
           pre_copy: nil,
           post_copy: nil,
           entrypoint: nil,
           entrypoint_args: nil

  setup do
    reset_env
  end

  test "Create Dockerfile contents" do
    Application.put_env(:exrm_docker, :image, "debian")
    Application.put_env(:exrm_docker, :version, "1234")
    Application.put_env(:exrm_docker, :maintainer, "Potion Maker")
    ExrmDocker.build_dockerfile("my_project")
    expected = """
    FROM debian:1234
    MAINTAINER Potion Maker

    COPY rel /rel

    ENTRYPOINT [\"/rel/my_project/bin/my_project\"]
    """
    {:ok, result} = File.read("_build/exrm_docker/Dockerfile")
    assert expected == result
  end

  test "Create Dockerfile post and pre copy" do
    Application.put_env(:exrm_docker, :pre_copy, "VOLUME [\"/var/lib\"]")
    Application.put_env(:exrm_docker, :post_copy, "EXPOSE 80 443")
    ExrmDocker.build_dockerfile("my_project")
    expected = """
    FROM centos

    VOLUME ["/var/lib"]
    COPY rel /rel
    EXPOSE 80 443
    ENTRYPOINT [\"/rel/my_project/bin/my_project\"]
    """
    {:ok, result} = File.read("_build/exrm_docker/Dockerfile")
    assert expected == result
  end

  test "Create Dockerfile with argument" do
    Application.put_env(:exrm_docker, :entrypoint_args, "console")
    ExrmDocker.build_dockerfile("my_project")
    expected = """
    FROM centos


    COPY rel /rel

    ENTRYPOINT [\"/rel/my_project/bin/my_project console\"]
    """
    {:ok, result} = File.read("_build/exrm_docker/Dockerfile")
    assert expected == result
  end

  defp reset_env do
    @default |> Enum.each(fn({key, value}) ->
      Application.put_env(:exrm_docker, key, value)
    end)
  end
end
