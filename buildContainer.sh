#!/bin/bash

organisation="caaqe"
image_name="azure-image-builder"
image_tag="latest"
docker build -t ${image_name}:${image_tag} --file Dockerfile .
exitCode=$?

if [[ ${exitCode} -eq 0 ]]; then
  echo "Docker image ${image_name}:${image_tag} build done."
else
  echo "Build failed."
  exit 2
fi
read -r -p "Do you like to push the image as ${organisation}/${image_name}:${image_tag}? [y|N]" REPLY
if [[ -z "$REPLY" || ${REPLY} =~ ^[Nn](o)?$ ]]; then
  echo -e "Image push was skipped..."
  exit 0
else
  echo -e "Push ${organisation}/${image_name}:${image_tag}...\n"
  docker tag ${image_name}:${image_tag} ${organisation}/${image_name}:${image_tag}
  docker push ${organisation}/${image_name}:${image_tag}
fi