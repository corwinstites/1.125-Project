close all
rootdir = 'C:\Users\2021\Documents\1.125\Project\Data\NetCDF Files Only';
filelist = dir(fullfile(rootdir, '**\*.*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
data = cell(size(filelist, 1)+1, 10);
empty_rows = NaN(1, size(filelist, 1));
data(:) = {NaN};
data(1, :) = {'Latitude' 'Longitude' 'Month Number' 'Depth Array' 'Speed Array' 'Salinity Array' 'Pressure Array' 'Conductivity Array' 'Temperature Array' 'Density Array'};
lat_lon = NaN(size(filelist, 1), 2);
do_every = 100;
for i = 1:size(filelist, 1)-1
    if mod(i, do_every) == 0 
        lat = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'lat');
        lon = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'lon');
        dep = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'depth');
        month_num = month(datetime(ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'time'), 'ConvertFrom', 'posixtime'));
        val_missing = 0;
        try
            speed = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'soundspeed');
        catch
            try
                speed = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'sound_speed');
            catch
                val_missing = 1;
            end
        end        
        try
            sal = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'salinity');
        catch
            sal = NaN;
        end
        try
            press = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'pressure');
        catch
            press = NaN;
        end
        try
            cond = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'conductivity');
        catch
            cond = NaN;
        end
        try
            temp = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'temperature');
        catch
            temp = NaN;
        end
        try
            dens = ncread(strcat(filelist(i).folder, '\', filelist(i).name), 'density');
        catch
            dens = NaN;
        end
        if lon < 0 && lon > -190 && lat > 0 && val_missing == 0 
            lat_lon(i, 1) = lat; 
            lat_lon(i, 2) = lon;
            data(i+1, 1) = {string(lat)};
            data(i+1, 2) = {string(lon)};
            data(i+1, 3) = {string(month_num)};
            data(i+1, 4) = {strjoin(string(dep))};
            data(i+1, 5) = {strjoin(string(speed))};
            if ~isnan(sal)
                data(i+1, 6) = {strjoin(string(sal))};
            else
                data(i+1, 6) = {NaN};
            end
            if ~isnan(press)
                data(i+1, 7) = {strjoin(string(press))};
            else
                data(i+1, 7) = {NaN};
            end
            if ~isnan(cond)
                data(i+1, 8) = {strjoin(string(cond))};
            else
                data(i+1, 8) = {NaN};
            end
            if ~isnan(temp)
                data(i+1, 9) = {strjoin(string(temp))};
            else
                data(i+1, 9) = {NaN};
            end
            if ~isnan(dens)
                data(i+1, 10) = {strjoin(string(dens))};
            else
                data(i+1, 10) = {NaN};
            end
        end
    else
       empty_rows(i) = i+1;
    end
end

lat_lon = rmmissing(lat_lon);
empty_rows = rmmissing(empty_rows);
data(empty_rows, :) = [];
figure 
worldmap("North America")
load coastlines
load topo60c
geoshow(topo60c,topo60cR,'DisplayType','surface')
demcmap(topo60c)
geoshow(lat_lon(:, 1), lat_lon(:, 2),...
        'DisplayType', 'point',...
        'Marker', 'o',...
        'MarkerEdgeColor', 'r',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 3)

