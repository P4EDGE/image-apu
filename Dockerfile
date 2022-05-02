FROM debian:bullseye-20220418

ARG UID=1000
ARG GID=1000
ARG USERNAME=builder

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y -qq simple-cdd sudo && \
    groupadd --gid $GID $USERNAME && \
    useradd --uid $UID --gid $GID -m $USERNAME && \
    mkdir -p mkdir -p /home/$USERNAME/build_image && \
    chown $UID:$GID /home/$USERNAME/build_image

USER $USERNAME
WORKDIR /home/$USERNAME/build_image
CMD ["build-simple-cdd", "--profiles", "p4edge", "--dist", "bullseye"]
