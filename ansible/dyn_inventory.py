#!/usr/bin/env python3
import logging
import json
import argparse
import yandexcloud
from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub
from yandex.cloud.compute.v1.instance_service_pb2 import (
    AttachedDiskSpec,
    CreateInstanceRequest,
    DeleteInstanceRequest,
    DnsRecordSpec,
    ListInstancesRequest,
    NetworkInterfaceSpec,
    OneToOneNatSpec,
    PrimaryAddressSpec,
    ResourcesSpec,
    StartInstanceRequest,
    StopInstanceRequest,
    UpdateInstanceRequest,
    UpdateInstanceNetworkInterfaceRequest,
)
from google.protobuf.json_format import MessageToDict

ANSIBLE_METADATA = {
    "metadata_version": "1.1",
    "status": ["preview"],
    "supported_by": "community",
}

ANSIBLE_LIST_STRUCT = {
    "_meta": ""
}


SA_FILE = '/home/sterh/yandex_svc_key.json'
FOLDER_ID = 'b1gs4m14eth4n4rjck3k'

def parse_args():
    """command-line options"""
    parser = argparse.ArgumentParser(description="Yandex Cloud inventory script")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--list', action='store_true')
    group.add_argument('--host')
    return parser.parse_args()

def list_running_hosts():
    with open(SA_FILE) as infile:
        sdk = yandexcloud.SDK(service_account_key=json.load(infile))
    instance_service = sdk.client(InstanceServiceStub)
    yc_instances = MessageToDict(instance_service.Get(ListInstancesRequest(folder_id=FOLDER_ID)))
    instances = {}
    for instance in yc_instances['instances']:
        print(instance)
        instances.update({instance['name']: {"ansible_host":instance['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address'] } } )
    print(instances, type(instances))
    return {"_meta":{"hostvars": instances }}

def get_host_details(hst_name:str):
    with open(SA_FILE) as infile:
        sdk = yandexcloud.SDK(service_account_key=json.load(infile))
    instance_service = sdk.client(InstanceServiceStub)
    yc_instances = MessageToDict(instance_service.Get(ListInstancesRequest(folder_id=FOLDER_ID)))
    instances = {}
    for instance in yc_instances['instances']:
        if instance['name'] ==
        instances.update({instance['name']: {"ansible_host":instance['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address'] } } )
    return {"_meta":{"hostvars": instances }}


def main():
    logging.basicConfig(level=logging.INFO)
    args = parse_args()
    if args.list:
        hosts = list_running_hosts()
        print(hosts)
        exit(0)
        json.dump({'vagrant': hosts}, sys.stdout)
    else:
        details = get_host_details(args.host)
        json.dump(details, sys.stdout)

if __name__ == '__main__':
    main()
