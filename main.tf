/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_compute_instance" "bad_vm" {
  name         = "test"
  project      = "your_project"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  labels = {
    data_owner          = "xingao"
    data_classification = "foo"
  }
}

# resource "google_bigquery_dataset" "default" {
#   project                     = "your_project"
#   dataset_id                  = "foo"
#   friendly_name               = "test"
#   description                 = "This is a test description"
#   location                    = "EU"
#   default_table_expiration_ms = 3600000

#   labels = {
#     env = "default"
#   }
# }

resource "google_storage_bucket" "image-store" {
  project  = "your_project"
  name     = "image-store-bucket"
  location = "EU"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_compute_firewall" "allow-all-ingress" {
  name          = "allow-all-ingress"
  project       = "your_project"
  network       = "default"
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  priority      = "2000"

  allow {
    protocol = "all"
  }
}
