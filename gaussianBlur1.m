function gaussianBlur1(img_path,sigma)
    tic;
    % Import image
    img = imread(img_path);

    % Defining Gaussian kernel
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

    % Applying Gaussian blur on every RGB channel using conv2 function of 2D convolution
    red = conv2(double(img(:,:,1)), h, 'same');
    green = conv2(double(img(:,:,2)), h, 'same');
    blue = conv2(double(img(:,:,3)), h, 'same');

    % Combining three resulting channels into new blured picture
    blurred = uint8(cat(3, red, green, blue));

    % Result showcase
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

