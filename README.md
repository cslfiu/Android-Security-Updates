# 50 Shades of Support: A Device-Centric Analysis of Android Security Updates

This repository contains the data and code used in our paper, "50 Shades of Support: A Device-Centric Analysis of Android Security Updates".

In the first step, we explain the data collection and preprocessing. In the second step, we provide the code for the analysis and results. Data collected during the first step is shared under the folder [Data](./Data/). For the reproducibility of the results, you can directly start from the second step. 

# 1. Data Collection and Preprocessing

The dataset in the paper is collected from official and open-source sources. We put significant efforts into the collection of the dataset, which we offer to the research community for use.

## Security Updates
- **Samsung**: Samsung informs the availability of firmware for each `<model,CSC>` with a unique URL format: `https://doc.samsungmobile.com/<model>/<CSC>/doc.html`. For instance: [https://doc.samsungmobile.com/SM-G960U1/CHA/doc.html](https://doc.samsungmobile.com/SM-G960U1/CHA/doc.html). The `model` and `CSC` information can be retrieved from the device settings. To compile a comprehensive list, we generated all possible combinations using the models from [Samsung's Knox-supported device list](https://www.samsungknox.com/en/knox-platform/supported-devices) and [a community-compiled CSC list](https://tsar3000.com/list-of-samsung-csc-codes-samsung-firmware-csc-codes). We then queried the database for all potential models and CSC pairs. In total, we downloaded 354,165 security updates published between April 2015 and March 2023. Each security update contains the build number, android version, release date, and security patch level. We assigned the country-carrier information via the CSC list and the device name using the Knox-supported device list. The full list of security updates can be found [samsung-security-updates](./Data/Samsung/samsung-security-updates/). Similarly, the downloaded CSC list can be found [CSC-list.csv](./Data/Samsung/CSC-list.csv) and the device list can be [knox-models-all.csv](./Data/Samsung/knox-models-all.csv). In total, we found unique 21461 `model-CSC` pairs containing 273 unique CSCs and 1073 models. After assigning country-carrier and device names, we found 97 countries, 109 carriers, and 275 unique devices (e.g., Galaxy S22). 

- **Xiaomi**: Xiaomi releases firmware via [an official API](https://sgp-api.buy.mi.com/bbs/api/global/phone/getlinepackagelist). We downloaded the historical data from [a third-party website](https://github.com/XiaomiFirmwareUpdater/miui-updates-tracker/blob/master/data/latest.yml) that's been fetching official security updates every six hours since 2018. This dataset currently comprises 2,286 security updates from December 2014 to June 2023. Xiaomi updates are specified for `device-region` pairs. The total list included 10 regions and 223 devices (combined using regional names). The full list of security updates can be found in [devices.yml](./Data/Xiaomi/devices.yml). We also downloaded the changelogs from [the same source](https://xiaomifirmwareupdater.com/miui/) and saved them in [changelogs.csv](./Data/Xiaomi/changelogs.csv), which we included the resulting SPLs for our analysis.

- **Oppo**: Oppo updates the firmware on their regional software update websites, e.g., [Updates for Oppo A11k in India](https://support.oppo.com/in/software-update). We constructed all possible country-device pairs, resulting in data from 1,144 pairs, totaling 9,416 security updates across 72 devices and 35 countries. We collected data from 1144 country-device pairs containing 9373 security updates for 72 devices used across 35 countries. Each firmware includes an update date, which we used as a release date. However, Oppo only releases the change log including the SPL for the latest release. Therefore, we downloaded firmware to extract the SPL from the configuration files. We included the resulting SPLs in [firmware_SPLs.csv](./Data/Oppo/firmware_SPLs.csv) from the downloaded firmware in our analysis. 

- **Google**: Google publishes firmware images for Pixel and Nexus devices on [a dedicated website](https://developers.google.com/android/images). We identified the security patch levels using [build numbers table](https://source.android.com/docs/setup/about/build-numbers). We only used OTA images as we aimed to characterize the updates received by the regular end user. We also excluded Nexus devices. In total, we included 900 updates received by 20 Pixel devices in our analysis.

## Support Lists

- **Samsung**: Samsung's [list of supported devices](https://security.samsungmobile.com/workScope.smsb) distinguishes between devices receiving monthly, quarterly, and biannual support, and wearable devices that get security updates. We downloaded 508 snapshots from [Wayback Machine](https://web.archive.org/web/20230401000000*/https://security.samsungmobile.com/workScope.smsb), ranging from October 2017 to March 2023, capturing 258 unique devices. The snapshots can be found in the folder [samsung-support-lists](./Data/Samsung/samsung-support-lists/). Moreover, the extracted support timelines can be found [timelines_samsung_devices_v1.csv](./Data/Samsung/timelines_samsung_devices_v1.csv).

- **Xiaomi**: We downloaded Xiaomi's supported devices from [Wayback Machine](https://web.archive.org/web/20210501000000*/https:/www.mi.com/global/service/support/security-update.html) and EOL product list from [this dedicated page](https://trust.mi.com/misrc/updates/phone?tab=policy). The extracted support timelines of Xiaomi devices can be seen [timelines_Xiaomi.csv](./Data/Xiaomi/timelines_Xiaomi.csv).

- **Oppo**: Oppo's list of supported devices can be found on [this page](https://security.oppo.com/en/mend). The extracted support timelines of Xiaomi devices can be seen [timelines_Oppo.csv](./Data/Oppo/timelines_Oppo.csv).

- **Google**: Supported [Nexus](https://support.google.com/nexus/answer/11227897) and [Pixel](https://support.google.com/pixelphone/answer/4457705) devices are presented on separate dedicated pages. Google's support lists can be seen [Google-support-list.xlsx](./Data/Google/Google-support-list.xlsx).

**Additional Datasets**:

- **NIST CVE Database**: We downloaded all CVEs and their additional information from 2002-2023 via [NIST database](https://nvd.nist.gov/vuln/data-feeds). 

- **Samsung Knox Supported Devices**: We used models, platforms, device types, and Android Enterprise Recommended (AER) devices information from Samsung's [Knox device list](https://www.samsungknox.com/en/knox-platform/supported-devices). The full list can be found in [knox-models-all.csv](./Data/Samsung/knox-models-all.csv).

- **AER-certified Devices**: We downloaded the list of AER-certified devices from Google's [list of AER devices](https://androidenterprisepartners.withgoogle.com/). The full list can be found [here](./Data/AER-devices-all-vendors.xlsx).

- **Android Security Bulletin**: We downloaded all [AOSP's security bulletin](https://source.android.com/docs/security/bulletin) and we used these lists to assign the CVEs to the Android version for the risk analysis of unpatched devices. The full list can be found in [AOSP-bulletins.csv](./Data/AOSP-bulletins.csv).

- **Chipsets**: We gathered the chipset information for the devices from [Samsung's website](https://www.samsung.com/us/smartphones/galaxy-s22-ultra/buy/galaxy-s22-ultra-128gb-unlocked-sm-s908uzkaxaa/) and augmented with data from partners like [carriers](https://www.t-mobile.com/cell-phone/samsung-galaxy-s22) for older devices. The chipset information for all devices can be found [chipsets.xlsx](./Data/chipsets.xlsx).


# 2. Analysis and Results

**Prerequisite Installations**: Ensure you have [**Jupyter Notebook**](https://jupyter.org/install) installed, and Python modules such as **Pandas**, **Numpy**, and others specified for each script.  
 

We  provide the code used for analysis alongside the results for the complete reproducibility of our study. Our code consists of five sets of experiments:

 - [Support Lists](./Code/Dataset%20(Support%20Lists).ipynb): This code includes the statistics about the support lists given in Section 3B. It is also used to extract the support type and support timeline of the devices, which is later used for evaluating the impact of the support type presented in Section 6A. 
 - [Part-1: Supported Period](./Code/Part-1%20Supported%20Period.ipynb): This code includes the dataset stats reported in Section 3A and the results of the supported period analysis given in Section 4A.
 - [Part-2: Unpatched Analysis](./Code/Part-2%20Unpatched%20Analysis.ipynb): This code includes the results of unpatched device analysis given in Section 4B - Part-2: Unsupported Period. For the NIST CVE dataset used in this section, we refer to [the original website](https://nvd.nist.gov/vuln/data-feeds), in which the dataset can be directly downloaded. (Download the JSON files of all years under the [folder](./Data/NIST-all/).)
 - [Factor Analysis](./Code/Factor%20Analysis.ipynb): This code includes the results for the impacting factor analysis in Section 5.
 - [Key Issues](./Code/Key-Issues.ipynb): The code here includes examples of the key issues such as inconsistency examples or discrepancies in AER-certified devices given in Section 6.

## Cite Our Work

If you find our work useful, please consider citing our paper. Here is the BibTeX entry for our paper:

```
@inproceedings{anon2024fifty,
    title={50 Shades of Support: A Device-Centric Analysis of Android Security Updates},
    author={Author1, Anon and Author2, Anon and Author3, Anon},
    booktitle={Network and Distributed System Security Symposium},
    year={2024}
}
```

# Contact

Please send an email to andsec87 (at) gmail (dot) com if you have any questions.

 

 

 
 
 
 


