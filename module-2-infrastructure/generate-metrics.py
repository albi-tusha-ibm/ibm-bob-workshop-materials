#!/usr/bin/env python3
"""
Generate realistic monitoring metrics CSV files for infrastructure module
"""

import csv
import random
from datetime import datetime, timedelta

def generate_cpu_usage_report():
    """Generate CPU usage metrics for 30 days"""
    filename = 'module-2-infrastructure/monitoring/metrics/cpu-usage-report.csv'
    
    servers = [
        'web-01', 'web-02', 'web-03', 'web-04', 'web-05',
        'app-01', 'app-02', 'app-03', 'app-04', 'app-05', 'app-06',
        'db-primary', 'db-replica'
    ]
    
    start_date = datetime.now() - timedelta(days=30)
    
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['timestamp', 'server', 'cpu_percent', 'load_avg_1m', 'load_avg_5m', 'load_avg_15m', 'status'])
        
        for day in range(30):
            for hour in range(24):
                timestamp = start_date + timedelta(days=day, hours=hour)
                
                for server in servers:
                    # Simulate different usage patterns
                    if 'web' in server:
                        base_cpu = 65 + random.randint(-10, 25)
                        if 8 <= hour <= 18:  # Business hours
                            base_cpu += random.randint(10, 20)
                    elif 'app' in server:
                        base_cpu = 70 + random.randint(-15, 25)
                        if 8 <= hour <= 18:
                            base_cpu += random.randint(15, 25)
                    else:  # database
                        base_cpu = 75 + random.randint(-10, 20)
                        if 8 <= hour <= 18:
                            base_cpu += random.randint(10, 15)
                    
                    # Add some spikes
                    if random.random() < 0.05:
                        base_cpu = min(98, base_cpu + random.randint(15, 30))
                    
                    cpu_percent = max(10, min(99, base_cpu))
                    load_1m = round(cpu_percent / 25 + random.uniform(-0.5, 0.5), 2)
                    load_5m = round(load_1m * 0.9 + random.uniform(-0.2, 0.2), 2)
                    load_15m = round(load_5m * 0.95 + random.uniform(-0.1, 0.1), 2)
                    
                    status = 'WARNING' if cpu_percent > 80 else 'CRITICAL' if cpu_percent > 90 else 'OK'
                    
                    writer.writerow([
                        timestamp.strftime('%Y-%m-%d %H:%M:%S'),
                        server,
                        cpu_percent,
                        load_1m,
                        load_5m,
                        load_15m,
                        status
                    ])
    
    print(f"Created {filename}")

def generate_memory_trends():
    """Generate memory utilization trends"""
    filename = 'module-2-infrastructure/monitoring/metrics/memory-trends.csv'
    
    servers = [
        'web-01', 'web-02', 'web-03', 'web-04', 'web-05',
        'app-01', 'app-02', 'app-03', 'app-04', 'app-05', 'app-06',
        'db-primary', 'db-replica'
    ]
    
    start_date = datetime.now() - timedelta(days=30)
    
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['timestamp', 'server', 'memory_total_gb', 'memory_used_gb', 'memory_percent', 'swap_used_gb', 'status'])
        
        for day in range(30):
            for hour in range(0, 24, 2):  # Every 2 hours
                timestamp = start_date + timedelta(days=day, hours=hour)
                
                for server in servers:
                    if 'web' in server:
                        total_mem = 16
                        base_used = 11 + random.uniform(-1, 3)
                    elif 'app' in server:
                        total_mem = 32
                        base_used = 24 + random.uniform(-2, 6)
                    else:  # database
                        total_mem = 64
                        base_used = 52 + random.uniform(-3, 8)
                    
                    # Memory tends to grow over time
                    base_used += (day / 30) * 2
                    
                    # Add business hours impact
                    if 8 <= hour <= 18:
                        base_used += random.uniform(1, 3)
                    
                    used_mem = min(total_mem * 0.98, base_used)
                    mem_percent = round((used_mem / total_mem) * 100, 1)
                    swap_used = round(random.uniform(0, 2), 2) if mem_percent > 80 else 0
                    
                    status = 'WARNING' if mem_percent > 85 else 'CRITICAL' if mem_percent > 95 else 'OK'
                    
                    writer.writerow([
                        timestamp.strftime('%Y-%m-%d %H:%M:%S'),
                        server,
                        total_mem,
                        round(used_mem, 2),
                        mem_percent,
                        swap_used,
                        status
                    ])
    
    print(f"Created {filename}")

def generate_disk_io_stats():
    """Generate disk I/O statistics"""
    filename = 'module-2-infrastructure/monitoring/metrics/disk-io-stats.csv'
    
    servers = [
        'web-01', 'web-02', 'web-03', 'web-04', 'web-05',
        'app-01', 'app-02', 'app-03', 'app-04', 'app-05', 'app-06',
        'db-primary', 'db-replica'
    ]
    
    start_date = datetime.now() - timedelta(days=30)
    
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['timestamp', 'server', 'disk_total_gb', 'disk_used_gb', 'disk_percent', 'read_iops', 'write_iops', 'read_mbps', 'write_mbps', 'status'])
        
        for day in range(30):
            for hour in range(0, 24, 3):  # Every 3 hours
                timestamp = start_date + timedelta(days=day, hours=hour)
                
                for server in servers:
                    if 'web' in server:
                        total_disk = 100
                        base_used = 45 + (day * 0.5)
                        base_iops_r = random.randint(50, 200)
                        base_iops_w = random.randint(30, 100)
                    elif 'app' in server:
                        total_disk = 200
                        base_used = 120 + (day * 1.2)
                        base_iops_r = random.randint(100, 400)
                        base_iops_w = random.randint(50, 200)
                    else:  # database
                        total_disk = 500
                        base_used = 450 + (day * 2.1)
                        base_iops_r = random.randint(500, 2000)
                        base_iops_w = random.randint(300, 1000)
                    
                    # Business hours increase I/O
                    if 8 <= hour <= 18:
                        base_iops_r = int(base_iops_r * 1.5)
                        base_iops_w = int(base_iops_w * 1.5)
                    
                    used_disk = min(total_disk * 0.98, base_used)
                    disk_percent = round((used_disk / total_disk) * 100, 1)
                    
                    read_mbps = round(base_iops_r * 0.004, 2)  # Approximate MB/s
                    write_mbps = round(base_iops_w * 0.004, 2)
                    
                    status = 'WARNING' if disk_percent > 90 else 'CRITICAL' if disk_percent > 95 else 'OK'
                    
                    writer.writerow([
                        timestamp.strftime('%Y-%m-%d %H:%M:%S'),
                        server,
                        total_disk,
                        round(used_disk, 2),
                        disk_percent,
                        base_iops_r,
                        base_iops_w,
                        read_mbps,
                        write_mbps,
                        status
                    ])
    
    print(f"Created {filename}")

if __name__ == '__main__':
    print("Generating monitoring metrics CSV files...")
    generate_cpu_usage_report()
    generate_memory_trends()
    generate_disk_io_stats()
    print("All metrics files generated successfully!")

# Made with Bob
