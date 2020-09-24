function [] = main()

if ~isdeployed
	disp('loading paths for IUHPC')
	addpath(genpath('/N/u/brlife/git/jsonlab'))
        addpath(genpath('/N/u/brlife/git/NIfTI'))
        addpath(genpath(pwd));
end

% load config.json
config = loadjson('config.json');

% run GLMdenoise
runGLMdenoise(config.fmri, config.events);

end
