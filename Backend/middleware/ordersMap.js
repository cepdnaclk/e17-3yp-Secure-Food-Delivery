const orders_map = new Map();

function add(key, obj) {
    orders_map.set(key, obj);
}

function del(key) {
    orders_map.delete(key);
}

function find(key) {
    return orders_map.get(key);
}

module.exports.add = add;
module.exports.del = del;
module.exports.find = find;