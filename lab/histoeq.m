function[final] = histoeq(channel)

[rows,columns] = size(channel);
final = uint8(zeros(rows,columns));
pixels = rows * columns;

freq = zeros(256,1);
pdf = zeros(256,1);

for i = 1 : 1 : rows
    for j = 1 : 1 : columns
        k = channel(i,j);
        freq(k+1) = freq(k+1)+1;
        pdf(k+1) = freq(k+1) / pixels;
    end
end

sum =0 ;
intensity = 255;
cdf = zeros(256,1);
cum = zeros(256,1);
out = zeros(256,1);

for i = 1 : 1 : size(pdf)
    sum =sum+freq(i);
    cum(i) = sum;
    cdf(i) = cum(i) / pixels;
    out(i) = round(cdf(i) * intensity);
end


for i = 1 : 1 : rows
    for j = 1 : 1 : columns
        final(i,j) = out(channel(i,j)+1);
    end
end