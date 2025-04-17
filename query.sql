/* Tables for Advertisers, Campaigns, and AdMetrics */

CREATE TABLE Advertisers (
    advertiser_id VARCHAR(255) PRIMARY KEY,
    advertiser_name VARCHAR(255),
    account_manager VARCHAR(255)
);

CREATE TABLE Campaigns (
    campaign_id VARCHAR(255) PRIMARY KEY,
    campaign_name VARCHAR(255),
    advertiser_id VARCHAR(255),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10, 2),
    FOREIGN KEY (advertiser_id) REFERENCES Advertisers(advertiser_id)
);

CREATE TABLE AdMetrics (
    report_date DATE,
    campaign_id VARCHAR(255),
    impressions INT,
    clicks INT,
    spend DECIMAL(10, 2),
    device_type VARCHAR(255),
    FOREIGN KEY (campaign_id) REFERENCES Campaigns(campaign_id)
);

/* Sample data */

INSERT INTO Advertisers (advertiser_id, advertiser_name, account_manager)
VALUES 
('ADV-111', 'Company A', 'Elon Musk'),
('ADV-222', 'Company B', 'Donald Trump'),
('ADV-333', 'Company C', 'Mark Zuckerberg');

INSERT INTO Campaigns (campaign_id, campaign_name, advertiser_id, start_date, end_date, budget)
VALUES 
('CID-ABC111', 'Campaign 1', 'ADV-111', '2025-02-05', '2025-05-01', 6000.00),
('CID-ABC222', 'Campaign 2', 'ADV-222', '2025-02-10', '2025-06-01', 10000.00),
('CID-ABC333', 'Campaign 3', 'ADV-333', '2025-03-01', '2025-04-01', 2000.00);

INSERT INTO AdMetrics (report_date, campaign_id, impressions, clicks, spend, device_type)
VALUES
('2025-04-10', 'CID-ABC111', 25000, 505, 75.00, 'Desktop'),
('2025-04-15', 'CID-ABC111', 3500, 600, 550.00, 'Mobile'),
('2025-04-10', 'CID-ABC222', 1500, 55, 650.00, 'Tablet'),
('2025-04-12', 'CID-ABC222', 1800, 85, 470.00, 'Mobile'),
('2025-04-14', 'CID-ABC333', 900, 90, 950.00, 'Desktop');

/* Q1 Filtering and Ordering*/

SELECT campaign_id, campaign_name
FROM Campaigns
WHERE start_date BETWEEN '2025-02-01' AND '2025-02-28'
  AND budget > 5000.00
ORDER BY budget DESC;

/* Q2: Cost Per Click */

SELECT campaign_id, device_type,
       CASE 
           WHEN SUM(clicks) > 0 THEN SUM(spend) / SUM(clicks)
           ELSE 'Unknown'
       END AS cpc
FROM AdMetrics
WHERE campaign_id IN ('CID-ABC111', 'CID-ABC222', 'CID-ABC333')
  AND report_date BETWEEN '2025-04-01' AND '2025-04-31'
GROUP BY campaign_id, device_type
HAVING cpc > 100;