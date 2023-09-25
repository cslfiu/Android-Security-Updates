# 50 Shades of Support: A Device-Centric Analysis of Android Security Updates

This repository contains the data and code used in our paper, "50 Shades of Support: A Device-Centric Analysis of Android Security Updates".

The dataset in the paper is collected from official and open-source sources. We put significant efforts into the collection of the dataset, which we offer to the research community for use. We also provide the code used for analysis alongside the results for the complete reproducibility of our study. 

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


# 1. Data Collection

## Security Updates
- **Samsung**: Samsung announces the availability of firmware for each `<model,CSC>` with a unique URL in the format: `https://doc.samsungmobile.com/<model>/<CSC>/doc.html`. For instance: [https://doc.samsungmobile.com/SM-G960U1/CHA/doc.html](https://doc.samsungmobile.com/SM-G960U1/CHA/doc.html). The `model` and `CSC` information can be retrieved from the device settings. To compile a comprehensive list, we generated all possible link combinations using the models from [Samsung's Knox-supported device list](https://www.samsungknox.com/en/knox-platform/supported-devices) and [a community-compiled CSC list](https://tsar3000.com/list-of-samsung-csc-codes-samsung-firmware-csc-codes). We then queried the database for all potential models and CSC pairs. In total, we downloaded 354,165 security updates published between April 2015 and March 2023 pertaining to 275 unique devices.

- **Xiaomi**: Xiaomi releases firmware via an official API. We downloaded historical data from [a third-party website](https://github.com/XiaomiFirmwareUpdater/miui-updates-tracker/blob/master/data/latest.yml) that's been fetching official security updates every six hours since 2018. This dataset currently comprises 2,286 security updates from December 2014 to June 2023.

- **Oppo**: Oppo updates the firmware on their regional software update websites, e.g., [Updates for Oppo A11k in India](https://support.oppo.com/in/software-update). We constructed all possible country-device pairs, resulting in data from 1,144 pairs, totaling 9,416 security updates across 72 devices and 35 countries.

- **Google**: Google publishes firmware images for Pixel and Nexus devices on [a dedicated website](https://developers.google.com/android/images). We identified the security patch levels using [build numbers table](https://source.android.com/docs/setup/about/build-numbers).

## Support Lists

- **Samsung**: Samsung's [list of supported devices](https://security.samsungmobile.com/workScope.smsb) distinguishes between devices receiving monthly, quarterly, and biannual support, and wearable devices that get security updates. We downloaded 508 snapshots of this list from the [Wayback Machine](https://web.archive.org/web/20230401000000*/https://security.samsungmobile.com/workScope.smsb), ranging from October 2017 to March 2023, capturing 258 unique devices.

- **Xiaomi**: We downloaded Xiaomi's supported devices from [Wayback Machine](https://web.archive.org/web/20210501000000*/https:/www.mi.com/global/service/support/security-update.html) and EOL product list from [this dedicated page](https://trust.mi.com/misrc/updates/phone?tab=policy).

- **Oppo**: Oppo's list of supported devices can be found on [this page](https://security.oppo.com/en/mend).

- **Google**: Supported [Nexus](https://support.google.com/nexus/answer/11227897) and [Pixel](https://support.google.com/pixelphone/answer/4457705) devices are presented on separate dedicated pages.

**Additional Datasets**:

- **NIST CVE Database**: We downloaded all CVEs and their additional information from 2002-2023 via [the NIST database](https://nvd.nist.gov/vuln/data-feeds). 

- **Samsung Knox Supported Devices**: We used models, platforms, device types, and Android Enterprise Recommended (AER) devices information from Samsung's [Knox device list](https://www.samsungknox.com/en/knox-platform/supported-devices). The full list can be found [here](../Data/Samsung/knox-models-all.csv).

- **AER-certified Devices**: We downloaded the list of AER-certified devices from Google's [list of AER devices](https://androidenterprisepartners.withgoogle.com/). The full list can be found [here](../Data/AER-devices-all-vendors.xlsx)

- **Android Security Bulletin**: We downloaded all [AOSP's security bulletin](https://source.android.com/docs/security/bulletin) and we used these lists to assign the CVEs to the Android version for the risk analysis of unpatched devices. The full list can be found [here](../Data/AOSP-bulletins.csv)

- **Chipsets**: We gathered the chipset information for the devices from [Samsung's website](https://www.samsung.com/us/smartphones/galaxy-s22-ultra/buy/galaxy-s22-ultra-128gb-unlocked-sm-s908uzkaxaa/) and augmented with data from partners like [carriers](https://www.t-mobile.com/cell-phone/samsung-galaxy-s22) for older devices. The full list can be found [here](../Data/chipsets.xlsx)


# 2. Dataset Characteristics and Preprocessing

- **Samsung**: Each Samsung security update contains the build number, android version, release date, and security patch level. We assigned each security update to the country-carrier via the CSC list and the device using the Knox-supported device list described above. The full list of security updates can be found [samsung-security-updates](../Data/Samsung/samsung-security-updates/). In total, we found unique 21461 `model-CSC` pairs containing 273 unique CSCs and 1073 models. After assigning, we found 97 countries and 109 carriers. Also, we found 275 unique devices (e.g., Galaxy S22) for all models (e.g., SM-970U). The release date of all updates ranges from April 2015 to March 2023.  

- **Xioami**: Xioami updates are specified for `model-region` pairs. The total list included 10 regions and 223 devices (combined using regional names). The full list can be found in [devices.yml](../Data/Xiaomi/devices.yml). We also downloaded the changelogs from [the same source](https://xiaomifirmwareupdater.com/miui/) and saved them in [devices.yml](../Data/Xiaomi/changelogs.csv). We included the resulting SPLs in the final list. 

- **Oppo**: We collected data from 1144 country-device pairs containing 9373 security updates for 72 devices used across 35 countries. Each firmware includes an update date, which we used as a release date. However, Oppo only releases the change log including the SPL for the latest release. Therefore, we downloaded firmware to extract the SPL from the configuration files. We included [the resulting SPLs](../Data/Oppo/firmware_SPLs.csv) from the downloaded firmware in our analysis. 

- **Google**: We only used 1110 full OTA images as we aim to characterize the updates received by the regular end user. We also excluded Nexus devices. In total, we included 20 Pixel devices in our analysis.


# 3. Analysis and Results
 
Our code consists of five sets of experiments:
 - [Support Lists](./Code/Dataset%20(Support%20Lists).ipynb): This code includes the statistics about the support lists given in Section 3B. It is also used to extract the support type and support timeline of the devices, which is later used for evaluating the impact of the support type presented in Section 6A. 
 - [Part-1: Supported Period](./Code/Part-1%20Supported%20Period.ipynb): This code includes the dataset stats reported in Section 3A and the results of the supported period analysis given in Section 4A.
 - [Part-2: Unpatched Analysis](./Code/Part-2%20Unpatched%20Analysis.ipynb): This code includes the results of unpatched device analysis given in Section 4B - Part-2: Unsupported Period. For the NIST CVE dataset used in this section, we refer to [the original website](https://nvd.nist.gov/vuln/data-feeds), in which the dataset can be directly downloaded. (Download all the json file for all years under the [folder](..Data/NIST-all/).)
 - [Factor Analysis](./Code/Factor%20Analysis.ipynb): This code includes the results for the impacting factor analysis in Section 5.
 - [Key Issues](./Code/Key-Issues.ipynb): The code here includes examples of the key issues such as inconsistency examples or discrepancies in AER-certified devices given in Section 6.

# Contact

Please send an email to andsec87 (at) gmail (dot) com if you have any questions.

 

 

 
 
 
 


