figure
% subplot(1,2,1)
hold on
for ii = 1:length(x)
    [s,f] = pwelch(rawdata{ii},window(@rectwin,length(rawdata{ii})),[],length(rawdata{ii}),data.fs);
    plot(f,s,'LineWidth',1,'Displayname',['Signal' num2str(ii)]')
end
xlabel('Frequency in Hz')
ylabel('PSD in (ms^{-2})^{2}/Hz')
legend toggle
title('Power Spectrum Density without Averaging and No Overlapping')
% hold off
% axis tight
xlim([500 2500])
%% 

nfftH = 2^14;
noverlapH = nfftH/2;


nwk = 14;
Dw = 3.7; % Rolling Element Dia in mm
Dt = 26.15; % Part Cirlce Dia in mm
alpha = 0; % Contact Angle in degrees

fko = 0.5 * fre * (1-(Dw/Dt)*cos(alpha));

fki = 0.5 * fre * (1+(Dw/Dt)*cos(alpha));

fa = 0.5 * fre * nwk * (1-(Dw/Dt)*cos(alpha));

fi = 0.5 * fre * nwk * (1+(Dw/Dt)*cos(alpha));

fwa = 0.5 * fre * (Dt/Dw) * (1-((Dw/Dt)*cos(alpha))^2);

fw = 2 * fwa;

damaged_fre = [fko ; fki ; fa ; fi ; fwa ; fw];

damaged_fre_name = { 'fko' ; 'fki' ; 'fa' ; 'fi' ; 'fwa' ; 'fw' };

% damaged_fre_name = { 'Cage rotational frequency with fix outer ring (fko)' ; 
%                         'Cage rotational frequency with fix inner ring (fki)' ; 
%                             'Rollover frequency of an irregularity on the outer ring (fa)' ; 
%                                 'Rollover frequency of an irregularity on the inner ring (fi)' ; 
%                                     'Rolling element rotation frequency or rolling element spin frequency (fwa)' ; 
%                                         'Rollover frequency of a rolling element irregularity on both tracks (fw)' };

% for ii = 1 : length(x)
ii = 1;
jj = 1;
    
%     for jj = 1 : length(damaged_fre)
        
        figure
        
        rawdata{ii} = rawdata{ii} - M.mean_m(ii);
        
        [s,f] = pwelch(rawdata{ii},window(@hann,nfft),noverlapH,nfftH,data.fs);
        
        plot(f,10*log10(s),'r','LineWidth',1.5,'Displayname',['Signal' num2str(ii)]')
        
%         plot(f,s,'r','LineWidth',2,'Displayname',['Signal' num2str(ii)]')
               
        hold on
        
        spacing = damaged_fre(jj,ii) .* (1:1:(10 * length(f)) / damaged_fre(jj,ii));
        
        plot(repmat(spacing,2,1),ylim,'-.k','LineWidth',1)
        
        hold off
        
        xlabel('Frequency in Hz')
        ylabel('PSD in dB')
        title(['PSD for Signal ', num2str(ii),' for ', damaged_fre_name{jj}])
        xlim([500 2500])
        ylim([-55 5])
%         xlim([0 2*10^4])

%         fig=figure;
%         destination='D:\Study\CM\ProjectTask\Figures\fig';
%         print([destination,num2str(jj),'.jpg']);
%         close(fig);
        
%     end
    
    
% end
%% 

nfftH = 2^14;
noverlapH = nfftH/2;


nwk = 14;
Dw = 3.7; % Rolling Element Dia in mm
Dt = 26.15; % Part Cirlce Dia in mm
alpha = 0; % Contact Angle in degrees

fko = 0.5 * fre * (1-(Dw/Dt)*cos(alpha));

fki = 0.5 * fre * (1+(Dw/Dt)*cos(alpha));

fa = 0.5 * fre * nwk * (1-(Dw/Dt)*cos(alpha));

fi = 0.5 * fre * nwk * (1+(Dw/Dt)*cos(alpha));

fwa = 0.5 * fre * (Dt/Dw) * (1-((Dw/Dt)*cos(alpha))^2);

fw = 2 * fwa;

damaged_fre = [fko ; fki ; fa ; fi ; fwa ; fw];

damaged_fre_name = { 'fko' ; 'fki' ; 'fa' ; 'fi' ; 'fwa' ; 'fw' };

% damaged_fre_name = { 'Cage rotational frequency with fix outer ring (fko)' ; 
%                         'Cage rotational frequency with fix inner ring (fki)' ; 
%                             'Rollover frequency of an irregularity on the outer ring (fa)' ; 
%                                 'Rollover frequency of an irregularity on the inner ring (fi)' ; 
%                                     'Rolling element rotation frequency or rolling element spin frequency (fwa)' ; 
%                                         'Rollover frequency of a rolling element irregularity on both tracks (fw)' };

% for ii = 1 : length(x)
ii = 1;
jj = 1;
    
%     for jj = 1 : length(damaged_fre)
        
        figure
        
         rawdata{ii} = rawdata{ii} - M.mean_m(ii);
        
        hilb = hilbert(rawdata{ii},length(rawdata{ii}));
        
        h = sqrt(real(hilb).^2+imag(hilb).^2);
        
        [sH,fH] = pwelch(h,window(@hann,nfftH),noverlapH,nfftH,data.fs);
        
        plot(fH,10*log10(sH),'r','LineWidth',1.5,'Displayname',['Signal' num2str(ii)]')
                   
        hold on
        
        spacing = damaged_fre(jj,ii) .* (1:1:(10 * length(f)) / damaged_fre(jj,ii));
        
        plot(repmat(spacing,2,1),ylim,'-.k','LineWidth',1)
        
        hold off
        
        xlabel('Frequency in Hz')
        ylabel('PSD in dB')
        title(['PSD for Signal ', num2str(ii),' for ', damaged_fre_name{jj}])
        xlim([200 1500])
        ylim([-40 -5])