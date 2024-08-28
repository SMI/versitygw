#!/usr/bin/env bash

# Copyright 2024 Versity Software
# This file is licensed under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

put_object_retention() {
  record_command "put-object-retention" "client:s3api"
  if [[ $# -ne 4 ]]; then
    log 2 "'put object retention' command requires bucket, key, retention mode, retention date"
    return 1
  fi
  error=$(aws --no-verify-ssl s3api put-object-retention --bucket "$1" --key "$2" --retention "{\"Mode\": \"$3\", \"RetainUntilDate\": \"$4\"}" 2>&1) || local put_result=$?
  if [[ $put_result -ne 0 ]]; then
    log 2 "error putting object retention:  $error"
    return 1
  fi
  return 0
}