[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.433-blue.svg)](https://doi.org/10.25663/brainlife.app.433)

# GLMdenoise for denoising task fMRI data

This app uses the [GLMdenoise toolbox](https://github.com/kendrickkay/GLMdenoise) to denoise and analyze task-based fMRI data.

GLMdenoise derives noise regressors on multiple runs of tfMRI data using principal component analysis (PCA) and regresses these out, resulting in a higher signal-to-noise ratio for voxels related to the experimental paradigm/task. At least two fMRI runs, with conditions repeated across runs, are required. Also required are the stimuli events, timings, and durations for each task fMRI run in the form of a "events.tsv" file that should accompany the inputted fMRI bold.nii.gz.

See [this page](http://kendrickkay.net/GLMdenoise/) and [this publication](https://www.frontiersin.org/articles/10.3389/fnins.2013.00247/full) for details on GLMdenoise.

### Authors
- [Kendrick Kay](kendrick@post.harvard.edu)

### Contributors
- [David Hunt](davhunt@iu.edu)

### Funding Acknowledgement
brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations
We kindly ask that you cite the following articles when publishing papers and code using this code. 

1.  Kay, K., Rokem, A., Winawer, J., Dougherty, R., & Wandell, B. (2013). GLMdenoise: a fast, automated technique for denoising task-based fMRI data. Frontiers in neuroscience, 7, 247. [https://doi.org/10.3389/fnins.2013.00247](https://doi.org/10.3389/fnins.2013.00247)

2.  Charest, I., Kriegeskorte, N., & Kay, K. N. (2018). GLMdenoise improves multivariate pattern analysis of fMRI data. NeuroImage, 183, 606-616. [https://doi.org/10.1016/j.neuroimage.2018.08.064](https://doi.org/10.1016/j.neuroimage.2018.08.064)

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University


## Running the App 

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/bl.app.1](https://doi.org/10.25663/bl.app.1) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
    "fmri": [
        "input/run1_bold.nii.gz",
        "input/run2_bold.nii.gz",
        "input/run3_bold.nii.gz",
        "input/run4_bold.nii.gz"
    ],
    "events": [
        "input/run1_events.tsv",
        "input/run2_events.tsv",
        "input/run3_events.tsv",
        "input/run4_events.tsv"
    ]
}
```

3. Launch the App by executing `main`

```bash
./main
```

### Sample Datasets

If you don't have your own fMRIs, Brainlife.io offers sample datasets on the site, or you can use [Brainlife CLI](https://github.com/brain-life/cli) and download datasets from the command line.

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5a0e604116e499548135de87 && mv 5a0e604116e499548135de87 input/track
bl dataset download 5a0dcb1216e499548135dd27 && mv 5a0dcb1216e499548135dd27 input/dtiinit
```

## Output

The main output of this App is a file called `output.mat`. This file contains following object.

The main output of this App are the denoised fMRI runs, found under `denoised_bold` in the current working directory (pwd)

```
    ├── denoised_bold
    │   ├── run1
    │   │   ├── bold.nii.gz
    │   │   ├── events.tsv
    │   ├── run2
    │   │   ├── bold.nii.gz
    │   │   ├── events.tsv
    │   ├── run3
    │   │   ├── bold.nii.gz
    │   │   ├── events.tsv
    │   ├── run4
    │   │   ├── bold.nii.gz
    │   │   ├── events.tsv

```

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.

  - Matlab: https://www.mathworks.com/products/matlab.html
  - jsonlab: https://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University
