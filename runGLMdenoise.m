function [] = runGLMdenoise(fmri, tsv)

data = {};
niis = {};
for ii = 1:size(fmri,2)
  niis{ii} = load_untouch_nii(char(fmri{ii}));
  data{ii} = niis{ii}.img;
end

tsvfiles = {};
for ii = 1:size(tsv,2)
  tsvfiles{ii} = tdfread(tsv{ii});
end

numruns = size(data,2);

if ~(size(data,2) == size(tsvfiles,2))
  error(['Each of the %d fMRI runs must have an events.tsv file associated with it specifying ' ...
    'onset times, duration, and trial type of each condition/stimulus.'], numruns)
end

if (size(data,2) < 2)
  error(['Must input at least two tfMRI runs with conditions repeated for the cross-validation and noise regression'])
end

all_trial_types = [];
for ii = 1:size(tsvfiles,2)
  all_trial_types = deblank(string(cat(1, all_trial_types, tsvfiles{ii}.trial_type)));
end

unique_conditions = unique(all_trial_types);
num_conditions = length(unique_conditions);

design = cell(1,numruns); % experimental design matrix to be inputted to GLMdenoisedata

for ii = 1:numruns

  these_conditions = deblank(string(tsvfiles{ii}.trial_type));
  [~, col_num] = ismember(these_conditions, unique_conditions);

  run_design = cell(1,num_conditions);

  for jj = 1:num_conditions
    C = [];
    onset_times = tsvfiles{ii}.onset(col_num == jj);
    durations = tsvfiles{ii}.duration(col_num == jj);
    
    for kk = 1:size(onset_times,1)
      stim_duration = round(durations(kk)/0.1);
      duration_vector = linspace(onset_times(kk),onset_times(kk)+(stim_duration)*0.1,stim_duration+1);
      run_design{jj} = [run_design{jj} duration_vector];
    end
  end

  design{ii} = run_design;

end

stimdur = 0.1;

tr = niis{1}.hdr.dime.pixdim(5);

hrf = getcanonicalhrf(0.1, tr)';

[results, denoiseddata] = GLMdenoisedata(design,data,stimdur,tr,'assume',hrf);


for ii = 1:size(denoiseddata,2)
  niis{ii}.hdr.dime.datatype = 16; niis{ii}.hdr.dime.bitpix = 32;
  niis{ii}.img = denoiseddata{ii};
  save_untouch_nii(niis{ii},sprintf('denoised_bold/run%d/bold.nii.gz',ii))
end


save('results.mat','results');



end
