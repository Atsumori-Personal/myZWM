function res = ps(x)

n = pow2(nextpow2(length(x)));
y = fft(x, n);

% f = (0:n-1)*(fs/n)/10;
power = abs(y).^2/n;
logpower = log(power);

%{
plot(f(1:floor(n/2)),logpower(1:floor(n/2)))
xlabel('Frequency')
ylabel('Power')
disp(mean(logpower));
%}

res = logpower;

end