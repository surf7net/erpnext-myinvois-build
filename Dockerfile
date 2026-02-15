FROM frappe/erpnext:v15.15.0

USER root
RUN apt-get update && apt-get install -y git

USER frappe
WORKDIR /home/frappe/frappe-bench

# Install the LHDN module and dependencies
RUN bench get-app --branch version-15 payments || true
RUN bench get-app --branch version-15 erpnext || true
RUN bench get-app https://github.com/ERPGulf/myinvois.git

# Finalize the build
RUN bench build --app payments --app erpnext --app myinvois
