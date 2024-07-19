function[rmse] = getDifference(input1, input2)
    if ~isequal(size(input1), size(input2))
        rmse = 0;
        fprintf("Input size different\n");
        return
    end
    if height(input1) ~= 3
        rmse = 0;
        fprintf("Wrong Input\n");
        return
    end
    if width(input1) < 3
        rmse = 0;
        fprintf("Need more radar points")
        return
    end
    rmse = double.empty;
    for i = 1:width(input1)
        for j=1:width(input1)
            for k=1:width(input1)
                if i==j || j==k || k==i
                    continue
                end
                T1 = getTransform(input1(:,[i j k]));
                T2 = getTransform(input2(:,[i j k]));
                trans1 = T1*[input1;ones(1,width(input2))];
                trans2 = T2*[input2;ones(1,width(input1))];
                trans1 = trans1(1:3,:);
                trans2 = trans2(1:3,:);
                trans1_r = [trans1(1:2,:); -trans1(3,:)];
                if sqrt(sum((trans1 - trans2).^2, "all")) < sqrt(sum((trans1_r - trans2).^2, "all"))
                    d = sqrt(sum((trans1 - trans2).^2, "all"));
                else
                    d = sqrt(sum((trans1_r - trans2).^2, "all"));
                end
                d = d/width(input1);
                rmse = [rmse; d, k, j, i];
            end
        end
    end
    rmse = sortrows(rmse);
end
