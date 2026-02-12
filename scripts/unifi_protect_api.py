#!/usr/bin/env python

import requests, warnings, json, os, time
warnings.filterwarnings('ignore')

UNIFI_PROTECT_API_KEY = os.getenv('UNIFI_PROTECT_API_KEY')

DOMAIN = 'https://192.168.0.86'
HEADERS = {
  'X-API-KEY': UNIFI_PROTECT_API_KEY,
  'Accept': 'application/json'
}

def make_request(url, headers=None, params=None):
  resp = requests.get(url, headers=headers, params=params, verify=False)
  print("Status:", resp.status_code)
  return resp.text

def get_app_info():
  url = f'{DOMAIN}/proxy/protect/integration/v1/meta/info'
  return make_request(url, HEADERS)

def get_cameras():
  url = f'{DOMAIN}/proxy/protect/integration/v1/cameras'
  return make_request(url, HEADERS)

def get_camera(camera_id):
  url = f'{DOMAIN}/proxy/protect/integration/v1/cameras/{camera_id}'
  return make_request(url, HEADERS)

def get_sensors():
  url = f'{DOMAIN}/proxy/protect/integration/v1/sensors'
  return make_request(url, HEADERS)

def get_events():
  url = f'{DOMAIN}/proxy/protect/api/events'
  params = { "limit": 10 }
  return make_request(url, HEADERS, params)

def main():
  app_info = get_app_info()
  cameras = get_cameras()
  camera = get_camera('68bc4a1801539303e4000411')
  sensors = get_sensors()
  # events = get_events()

  print(app_info)
  print(cameras)
  print(camera)
  print(sensors)
  # print(events)

main()



# https://192.168.0.86/proxy/protect/api/events?start=1769984521200&end=1769988121200&limit=10