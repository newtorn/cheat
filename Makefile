DOCKER_MANIFEST=DOCKER_CLI_EXPERIMENTAL=enabled docker manifest

docker-login-ci:
	docker login -u "$$DOCKER_USER" -p "$$DOCKER_PASS";

docker-manifest-annotate:
	echo ${VERSION}
	${DOCKER_MANIFEST} create --amend "newtorn/cheat:unstable"     "newtorn/cheat:amd64-unstable"     "newtorn/cheat:386-unstable"     "newtorn/cheat:armv7-unstable"     "newtorn/cheat:arm64-unstable"     "newtorn/cheat:ppc64le-unstable"
	${DOCKER_MANIFEST} create --amend "newtorn/cheat:${VERSION}" "newtorn/cheat:amd64-${VERSION}" "newtorn/cheat:386-${VERSION}" "newtorn/cheat:armv7-${VERSION}" "newtorn/cheat:arm64-${VERSION}" "newtorn/cheat:ppc64le-${VERSION}"
	${DOCKER_MANIFEST} annotate "newtorn/cheat:unstable"     "newtorn/cheat:amd64-unstable"       --os=linux --arch=amd64
	${DOCKER_MANIFEST} annotate "newtorn/cheat:${VERSION}" "newtorn/cheat:amd64-${VERSION}"   --os=linux --arch=amd64
	${DOCKER_MANIFEST} annotate "newtorn/cheat:unstable"     "newtorn/cheat:386-unstable"         --os=linux --arch=386
	${DOCKER_MANIFEST} annotate "newtorn/cheat:${VERSION}" "newtorn/cheat:386-${VERSION}"     --os=linux --arch=386
	${DOCKER_MANIFEST} annotate "newtorn/cheat:unstable"     "newtorn/cheat:armv7-unstable"       --os=linux --arch=arm --variant=v7
	${DOCKER_MANIFEST} annotate "newtorn/cheat:${VERSION}" "newtorn/cheat:armv7-${VERSION}"   --os=linux --arch=arm --variant=v7
	${DOCKER_MANIFEST} annotate "newtorn/cheat:unstable"     "newtorn/cheat:arm64-unstable"       --os=linux --arch=arm64
	${DOCKER_MANIFEST} annotate "newtorn/cheat:${VERSION}" "newtorn/cheat:arm64-${VERSION}"   --os=linux --arch=arm64
	${DOCKER_MANIFEST} annotate "newtorn/cheat:unstable"     "newtorn/cheat:ppc64le-unstable"     --os=linux --arch=ppc64le
	${DOCKER_MANIFEST} annotate "newtorn/cheat:${VERSION}" "newtorn/cheat:ppc64le-${VERSION}" --os=linux --arch=ppc64le


docker-manifest-push:
	${DOCKER_MANIFEST} push "newtorn/cheat:${VERSION}"
	${DOCKER_MANIFEST} push "newtorn/cheat:unstable"

