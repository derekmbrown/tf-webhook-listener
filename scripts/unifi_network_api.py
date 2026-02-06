#!/usr/bin/env python

import requests, warnings, json, os
warnings.filterwarnings('ignore')

UNIFI_NETWORK_API_KEY = os.getenv('UNIFI_NETWORK_API_KEY')

DOMAIN = 'https://192.168.0.1'
HEADERS = {
  'X-API-KEY': UNIFI_NETWORK_API_KEY,
  'Accept': 'application/json'
}

def make_request(url, headers):
  resp = requests.get(url, headers=headers, verify=False)
  print("Status:", resp.status_code)
  return resp.text

def get_app_info():
  url = f'{DOMAIN}/proxy/network/integration/v1/info'
  return make_request(url, HEADERS)

def get_sites():
  url = f'{DOMAIN}/proxy/network/integration/v1/sites'
  return make_request(url, HEADERS)

def get_site_id(sites):
  sites_json = json.loads(sites)
  return sites_json['data'][0]['id']

def get_clients(site_id):
  url = f'{DOMAIN}/proxy/network/integration/v1/sites/{site_id}/clients'
  return make_request(url, HEADERS)

def get_devices(site_id):
  url = f'{DOMAIN}/proxy/network/integration/v1/sites/{site_id}/devices'
  return make_request(url, HEADERS)

def get_networks(site_id):
  url = f'{DOMAIN}/proxy/network/integration/v1/sites/{site_id}/networks'
  return make_request(url, HEADERS)

def get_network_id(networks):
  networks_json = json.loads(networks)
  return networks_json['data'][0]['id']

def get_network_info(site_id, network_id):
  url = f'{DOMAIN}/proxy/network/integration/v1/sites/{site_id}/networks/{network_id}'
  return make_request(url, HEADERS)

def main():
  app_info = get_app_info()
  sites = get_sites()
  site_id = get_site_id(sites)
  clients = get_clients(site_id)
  devices = get_devices(site_id)
  networks = get_networks(site_id)
  network_id = get_network_id(networks)
  network_info = get_network_info(site_id, network_id)

  print(app_info)
  print(sites)
  print(site_id)
  print(clients)
  print(devices)
  print(networks)
  print(network_id)
  print(network_info)

main()
