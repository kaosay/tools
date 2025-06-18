#!/bin/bash


SCRIPTDIR=`dirname $0`

docker load -i ${SCRIPTDIR}/../images/gpu-operator-validator.tar
docker load -i ${SCRIPTDIR}/../images/container-toolkit.tar
docker load -i ${SCRIPTDIR}/../images/dcgm-exporter.tar
docker load -i ${SCRIPTDIR}/../images/k8s-device-plugin.tar
docker load -i ${SCRIPTDIR}/../images/node-feature-discovery.tar
docker load -i ${SCRIPTDIR}/../images/k8s-driver-manager.tar
docker load -i ${SCRIPTDIR}/../images/mirrored-pause.tar
docker load -i ${SCRIPTDIR}/../images/gpu-operator.tar
docker load -i ${SCRIPTDIR}/../images/csi-node-driver-registrar.tar
docker load -i ${SCRIPTDIR}/../images/cephcsi.tar
docker load -i ${SCRIPTDIR}/../images/gpu-operator-validator-v2492.tar
docker load -i ${SCRIPTDIR}/../images/container-toolkit-v1174.tar
