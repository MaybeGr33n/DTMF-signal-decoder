x = load("signal_data.txt");
x = x.';

a = 45 * 10^(-3); %длительность импульса (с)

n = (1 : length(x));
figure();
plot(n, x);
title('Data');
grid on;
%%
x2 = x.^2;
n2 = (1 : length(x2));

figure();
plot(n2, abs(fft(x2)));
title('Abs(fft(x^2))');
xlim([1 50])
grid on;
%%
N = length(x) / 24;
f_d = N / (85 * 10^(-3));

XB = reshape(x, N, []);
display(XB);

N1 = a * f_d;
XB = XB(1 : N1,:);
%%
XF = fft(XB);

figure();
plot(abs(XF));
grid on;
%%
f_nr = [697 770 852 941];
f_nc = [1209 1336 1477];

r = ceil(f_nr * N1 / f_d);
c = ceil(f_nc * N1 / f_d);

XR = XF(r + 1 ,: );
XC = XF(c + 1 ,: );

figure();
stem(abs(XR(:,4)))
hold on;
stem(abs(XC(:,4)))
xlim([0 5]); ylim([0 300]);
%%
[Rmax, ind_R] = max(abs(XR));
[Cmax, ind_C] = max(abs(XC));

dtmf = ['1', '2', '3';
        '4', '5', '6';
        '7', '8', '9';
        '*', '0', '#'];

s = dtmf(sub2ind(size(dtmf), ind_R, ind_C));
disp(s);
%%
fprintf('N = %d отсчётов\n', N);
fprintf('f_d = %d Гц\n', f_d);
fprintf('номера спектральных отсчетов, наиболее близких к частотам DTMF:\n');
disp([r, c]);
fprintf('s: %s \n', s);
