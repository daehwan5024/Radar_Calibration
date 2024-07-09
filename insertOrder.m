function [orders] = insertOrder(pdopList, num_radar)
% find the order of inserting radars.
% List all possible orders, if impossible, the cost is Inf
radars = 1:num_radar;
result = double.empty;

for i = 1:num_radar
    for j = 1:i-1
        for k=1:j-1
            temp = radars(radars~=i); temp = temp(temp~=j);
            temp = temp(temp~=k);
            permute = perms(temp);
            t = repmat([k, j, i], height(permute), 1);
            tt = [t permute];
            result = [result;tt];
        end
    end
end
orders_t = zeros(height(result), 1);
orders = [orders_t result];
    function[cost] = findCost(target, known)
        for ii=1:height(pdopList)
            if pdopList(ii, 2) ~= target
                continue
            end
            if ismember(pdopList(ii, 3), known) && ismember(pdopList(ii, 4), known) && ismember(pdopList(ii, 5), known)
                cost = pdopList(ii, 1);
                return
            end
        end
        cost = 1j;
    end

    function[cost] = getCost(orders_t)
        known = [orders_t(1), orders_t(2), orders_t(3)];
        cost = 0;
        for iii=4:width(orders_t)
            cost = cost + findCost(orders_t(iii), known);
            if ~isreal(cost)
                return
            end
            known = [known orders_t(iii)];
        end
    end
for i=1:height(orders)
    cost = getCost(orders(i, 2:end));
    if ~isreal(cost)
        orders(i, 1) = Inf(1,1);
    else
        orders(i, 1) = cost;
    end
end
orders = sortrows(orders);
end

