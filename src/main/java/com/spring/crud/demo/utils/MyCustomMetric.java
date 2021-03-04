package com.spring.crud.demo.utils;

import org.springframework.stereotype.Component;

import io.micrometer.core.instrument.Counter;

import io.micrometer.core.instrument.MeterRegistry;

@Component
public class MyCustomMetric {

    private final Counter myCounter;

    public MyCustomMetric(MeterRegistry registry) {
        myCounter = Counter.builder("mycustomcounter").description("This is my custom counter").register(registry);
    }

    public void countedCall() {
        myCounter.increment();
    }
}
