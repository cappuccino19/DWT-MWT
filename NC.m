function nc = NC(imageA, imageB)
% 计算两幅图像的归一化相关系数（Normalized Correlation Coefficient, NC）
%
% 输入参数:
% imageA - 第一幅图像（矩阵形式）
% imageB - 第二幅图像（矩阵形式，大小与imageA相同）
%
% 输出参数:
% nc - 归一化相关系数（NC值）

% 检查输入图像的大小是否相同
if ~isequal(size(imageA), size(imageB))
error('输入图像的大小必须相同');
end

% 计算图像的平均像素值
meanA = mean(imageA(:));
meanB = mean(imageB(:));

% 计算NC值的分子部分
numerator = sum((imageA(:) - meanA) .* (imageB(:) - meanB));

% 计算NC值的分母部分
denominator = sqrt(sum((imageA(:) - meanA).^2) * sum((imageB(:) - meanB).^2));

% 避免除以零的情况（理论上不应该发生，但数值计算中可能遇到极小值）
if denominator == 0
error('分母为零，无法计算NC值');
end

% 计算NC值
nc = numerator / denominator;
end

% 示例使用
% 读取两幅图像（这里假设它们已经以矩阵形式存在，或者你可以使用imread函数读取图像文件）
% imageA = imread('original_image.png'); % 读取原始图像，可能需要转换为灰度图像
% imageB = imread('encrypted_or_decrypted_image.png'); % 读取加密或解密后的图像

% 为了简化示例，这里我们创建两个随机矩阵作为图像A和B的替代

% 计算NC值