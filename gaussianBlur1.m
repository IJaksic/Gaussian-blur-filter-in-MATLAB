function gaussianBlur1(img_path,sigma)
    tic;
    % Učitaj sliku
    img = imread(img_path);

    % Definiraj Gaussovu jezgru
    hsize = 2*ceil(3*sigma)+1;
    h = zeros(hsize);
    for i=1:hsize
        for j=1:hsize
            x = i - ceil(hsize/2);
            y = j - ceil(hsize/2);
            h(i,j) = (1/2*pi*sigma^2)*exp(-(x^2 + y^2) / (2*sigma^2));
        end
    end
    h = h/sum(h(:));

    % Primijeni Gaussovo zamućenje na svaki kanal zasebno
    red = conv2(double(img(:,:,1)), h, 'same');
    green = conv2(double(img(:,:,2)), h, 'same');
    blue = conv2(double(img(:,:,3)), h, 'same');

    % Sastavi zamućene kanale u jednu sliku u boji
    blurred = uint8(cat(3, red, green, blue));

    % Prikazi izlaznu sliku
    figure;
    subplot(1,2,1);
    imshow(img);
    title('Original Image');
    subplot(1,2,2);
    imshow(blurred);
    title('Blurred Image');
    elapsed_time = toc;
    fprintf('Time: %f sec\n',elapsed_time);
end

