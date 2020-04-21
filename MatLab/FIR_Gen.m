freq = 25000;

bpFilt = designfilt( 'bandpassfir', ...
                     'FilterOrder',20, ...
                     'CutoffFrequency1', (freq - 100), ...
                     'CutoffFrequency2', (freq + 100), ...
                     'SampleRate', 1000000, ...
                     'DesignMethod', 'window',...
                     'Window', 'hamming' );

disp( firtype( bpFilt) );
disp( bpFilt.Coefficients );

% Convert coefficients to 18-bit fixed-point
bf = fi( bpFilt.Coefficients, true, 18);
hf = hex( bf );  % Get Hex form of coefficients

disp( hf );
fvtool(bpFilt);

