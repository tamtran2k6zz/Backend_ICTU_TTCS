package com.codegym.service;

import com.codegym.model.Product;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;

public class ProductServiceImpl implements ProductService {
    private static final Map<Integer, Product> PRODUCTS = new LinkedHashMap<>();
    private static final AtomicInteger NEXT_ID = new AtomicInteger(4);

    static {
        PRODUCTS.put(1, new Product(1, "Laptop Air 14", new BigDecimal("18990000"),
                "Laptop mỏng nhẹ, phù hợp học tập và làm việc.", "TechNova"));
        PRODUCTS.put(2, new Product(2, "Tai nghe Bluetooth", new BigDecimal("1290000"),
                "Tai nghe không dây với hộp sạc nhỏ gọn.", "SoundWave"));
        PRODUCTS.put(3, new Product(3, "Bàn phím cơ K87", new BigDecimal("1590000"),
                "Bàn phím cơ 87 phím, đèn nền tùy chỉnh.", "KeyWorks"));
        PRODUCTS.put(4, new Product(4, "Màn hình 27 inch", new BigDecimal("5490000"),
                "Màn hình IPS độ phân giải QHD.", "ViewPoint"));
    }

    @Override
    public List<Product> findAll() {
        synchronized (PRODUCTS) {
            return new ArrayList<>(PRODUCTS.values());
        }
    }

    @Override
    public Optional<Product> findById(int id) {
        synchronized (PRODUCTS) {
            return Optional.ofNullable(PRODUCTS.get(id));
        }
    }

    @Override
    public Product create(Product product) {
        synchronized (PRODUCTS) {
            int id = NEXT_ID.incrementAndGet();
            product.setId(id);
            PRODUCTS.put(id, product);
            return product;
        }
    }

    @Override
    public boolean update(int id, Product product) {
        synchronized (PRODUCTS) {
            if (!PRODUCTS.containsKey(id)) {
                return false;
            }
            product.setId(id);
            PRODUCTS.put(id, product);
            return true;
        }
    }

    @Override
    public boolean delete(int id) {
        synchronized (PRODUCTS) {
            return PRODUCTS.remove(id) != null;
        }
    }

    @Override
    public List<Product> searchByName(String name) {
        String query = name == null ? "" : name.trim().toLowerCase(Locale.ROOT);
        synchronized (PRODUCTS) {
            return PRODUCTS.values().stream()
                    .filter(product -> product.getName().toLowerCase(Locale.ROOT).contains(query))
                    .toList();
        }
    }
}
