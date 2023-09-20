# 50 Shades of Support: A Device-Centric Analysis of Android Security Updates

This repository contains the code and dataset used in the paper, "50 Shades of Support: A Device-Centric Analysis of Android Security Updates".

# 1. Data

The dataset in the paper is collected from official and open-source sources. The list of datasets and data collection methodology are as follows:

## 1.1 Security Updates

 - Samsung Security Updates History: Samsung publishes the availability of firmware for each <model,CSC> with a unique URL in the format of https://doc.samsungmobile.com/<model>/<CSC>/doc.html. An example is [https://doc.samsungmobile.com/SM-G960U1/CHA/doc.html](https://doc.samsungmobile.com/SM-G960U1/CHA/doc.html). The model and CSC information can be obtained from the device settings. We created all combinations of the links using the models from [Samsung's knox supported device list](https://www.samsungknox.com/en/knox-platform/supported-devices) and [a community-compiled CSC list](https://tsar3000.com/list-of-samsung-csc-codes-samsung-firmware-csc-codes). We queried the database for all possible pairs. In total, we downloaded 354165 security updates belonging to 275 devices published between April 2015-March 2023.

 - Xioami Security Updates History: Xiaomi releases the latest available firmware via an official API. We downloaded the historical data from [a third-party website](https://github.com/XiaomiFirmwareUpdater/miui-updates-tracker/blob/master/data/latest.yml) that has been fetching the official security updates every six hours since 2018. In total, this dataset includes 2286 official security updates right now, spanning from December 2014 to June 2023.

 - Oppo Security Updates History: Oppo releases firmware updates in their regional software update website (e.g., [Updates for Oppo A11k used in India](https://support.oppo.com/in/software-update)). We constructed all country-device pairs. We collected security updates of 1144 pairs containing 9416 security updates for 72 devices used across 35 countries. 

 - Google Security Updates History: Google releases the firmware images for Pixel and Nexus devices in [a dedicated website](https://developers.google.com/android/images). We identified the security patch levels using [build numbers table](https://source.android.com/docs/setup/about/build-numbers).

 ## 1.2 Support Lists
 - Samsung Support List: Samsung publishes the [list of supported devices](https://security.samsungmobile.com/workScope.smsb). The lists include the devices receiving monthly, quarterly, and biannual support separately, and the wearable devices that receive security updates. We downloaded 508 snapshots of this list from [Wayback Machine](https://web.archive.org/web/20230401000000*/https://security.samsungmobile.com/workScope.smsb). Snapshot dates range from October 2017 to March 2023 with a total of 258 unique devices included.
 - Xiaomi Support List: Xiaomi publishes the list of supported devices on [a dedicated webpage](https://trust.mi.com/misrc/updates/phone?tab=policy).
 - Oppo Support List: Oppo publishes the list of supported devices in [a dedicated webpage]([https://trust.mi.com/misrc/updates/phone?tab=policy](https://security.oppo.com/en/mend)).
 - Google Support List: Google publishes the list of supported [Nexus](https://support.google.com/nexus/answer/11227897) and [Pixel](https://support.google.com/pixelphone/answer/4457705) devices on dedicated web pages.
 
 The following additional datasets are used: 
 - NIST CVE Database: We downloaded the list of all CVEs published between 2002-2023 through [the NIST database](https://nvd.nist.gov/vuln/data-feeds).
 - Samsung Knox Supported Devices: We used the models, platforms, device type, and the list of Android Enterprise Recommended (AER) devices published in [Knox supported device list](https://www.samsungknox.com/en/knox-platform/supported-devices) by Samsung.
 - AER-certified Devices: We used the list of [Android Enterprise Recommended (AER) devices](https://androidenterprisepartners.withgoogle.com/) published by Google. 
 
 # 2. Code, Analysis, and Results
 
We make all of our code available for the reproducibility of the results. The code includes the figures as well. To reproduce the results, one needs to install Jupyter Notebook and other required Python modules (e.g., pandas, numpy).
 
 The code consists of four sets of experiments and their code:
 
 - [Part-1: Supported Period](./Code/Part-1%20Supported%20Period.ipynb): This code includes the dataset stats and the results of the initial analysis of the security updates dataset from all vendors.
 - [Part-2: Unpatched Analysis](./Code/Part-2%20Unpatched%20Analysis.ipynb): This code includes the results of unpatched device analysis for all vendors.
 - [Factor Analysis](./Code/Factor%20Analysis.ipynb): This code includes the results for the impacting factor analysis.
 - [Key Issues](./Code/Key-Issues.ipynb): The code here includes examples of the key issues such as inconsistency examples or discrepancies in AER-certified devices. 
 - [Dataset (Support Lists)](./Code/Dataset%20(Support%20Lists).ipynb): This code includes the timeline extraction script and analysis of support lists. 
 
 
 

 
 
 
 


