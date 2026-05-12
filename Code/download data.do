* ---------------------------------------------------------------------------- *
* --------------- Download data for "Regulating a Monopsonist" --------------- *
* ---------------------------------------------------------------------------- *

* ---------------------------------
* Set up
* ---------------------------------
* Set API key 
global ipums_api_key "59cba10d8a5da536fc06b59d9adece401eeb4a979b4ada87791e5793" 

* Set paths 
global ipums_data_dir  "`c(pwd)'/../data"
global ipums_final_dta "$ipums_data_dir/IPUMS data extract.dta"
global ipums_tmp_dir   "$ipums_data_dir/_ipums_tmp_extract"
cap mkdir "$ipums_data_dir"

* Set sample details 
global ipums_collection  "cps"
global ipums_description "CPS monthly and ASEC extract, Jan 2021-Dec 2025"
#delimit ;

global ipums_samples
    cps2021_01b cps2021_02s cps2021_03b cps2021_03s cps2021_04b cps2021_05b
    cps2021_06s cps2021_07s cps2021_08s cps2021_09s cps2021_10s cps2021_11s cps2021_12s
    cps2022_01s cps2022_02s cps2022_03b cps2022_03s cps2022_04s cps2022_05s
    cps2022_06s cps2022_07s cps2022_08s cps2022_09s cps2022_10s cps2022_11s cps2022_12s
    cps2023_01s cps2023_02s cps2023_03b cps2023_03s cps2023_04b cps2023_05s
    cps2023_06s cps2023_07s cps2023_08s cps2023_09s cps2023_10s cps2023_11s cps2023_12s
    cps2024_01s cps2024_02b cps2024_03b cps2024_03s cps2024_04b cps2024_05b
    cps2024_06s cps2024_07s cps2024_08s cps2024_09s cps2024_10s cps2024_11s cps2024_12s
    cps2025_01b cps2025_02s cps2025_03b cps2025_03s cps2025_04b cps2025_05s
    cps2025_06s cps2025_07b cps2025_08s cps2025_09s cps2025_11s cps2025_12s
;
#delimit cr
global ipums_variables "YEAR MONTH HWTFINL CPSID ASECFLAG ASECWTH PERNUM WTFINL ASECWT HOURWAGE2"

* ---------------------------------
* Retrieve data from IPUMS 
* ---------------------------------
python:
import os
import gzip
import shutil
from pathlib import Path
from sfi import Macro
from ipumspy import IpumsApiClient, MicrodataExtract

api_key = Macro.getGlobal("ipums_api_key").strip()
if not api_key:
    raise SystemExit("No IPUMS API key found in global ipums_api_key.")

collection  = Macro.getGlobal("ipums_collection")
description = Macro.getGlobal("ipums_description")
samples     = Macro.getGlobal("ipums_samples").split()
variables   = Macro.getGlobal("ipums_variables").split()

tmpdir    = Path(Macro.getGlobal("ipums_tmp_dir")).expanduser().resolve()
final_dta = Path(Macro.getGlobal("ipums_final_dta")).expanduser().resolve()

# Clean old temporary folder, if it exists
if tmpdir.exists():
    shutil.rmtree(tmpdir)
tmpdir.mkdir(parents=True, exist_ok=True)

# Make sure data folder exists
final_dta.parent.mkdir(parents=True, exist_ok=True)

ipums = IpumsApiClient(api_key)

extract = MicrodataExtract(
    collection=collection,
    description=description,
    samples=samples,
    variables=variables,
    data_format="stata"
)

extract.data_format = "stata"

ipums.submit_extract(extract)
print(f"Submitted IPUMS extract {extract.extract_id} for collection {collection}.")

ipums.wait_for_extract(extract)
ipums.download_extract(extract, download_dir=tmpdir)

# Find downloaded Stata file
dta_gz_files = sorted(tmpdir.glob("*.dta.gz"))
dta_files    = sorted(tmpdir.glob("*.dta"))

if dta_gz_files:
    gz_file = dta_gz_files[-1]
    tmp_dta = tmpdir / gz_file.name[:-3]  # remove .gz

    with gzip.open(gz_file, "rb") as src, open(tmp_dta, "wb") as dst:
        shutil.copyfileobj(src, dst)

elif dta_files:
    tmp_dta = dta_files[-1]

else:
    # Clean temporary files before exiting
    shutil.rmtree(tmpdir, ignore_errors=True)
    raise SystemExit(
        f"No .dta or .dta.gz file found in {tmpdir}. "
        "IPUMS may not have returned a Stata-format extract."
    )

# Replace final file if it already exists
if final_dta.exists():
    final_dta.unlink()

shutil.move(str(tmp_dta), str(final_dta))

# Delete all intermediate files
shutil.rmtree(tmpdir, ignore_errors=True)

Macro.setGlobal("ipums_final_dta_abs", str(final_dta))

print(f"Saved final Stata file to: {final_dta}")
end

* ---------------------------------
* Compress 
* ---------------------------------
use "$ipums_final_dta_abs", clear
compress
save "$ipums_final_dta_abs", replace
