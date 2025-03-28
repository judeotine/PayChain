import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Error "mo:base/Error";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Hash "mo:base/Hash";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
// Types for the payment system
type TransactionId = Nat;
type Amount = Nat;
type Timestamp = Int;
// Enhanced types for security and analytics
type RateLimit = {
    requestsPerMinute: Nat;
    requestsPerHour: Nat;
    requestsPerDay: Nat;
    lastReset: Timestamp;
    requestCount: Nat;
};
type FraudPattern = {
    #HighVelocity;
    #MultipleSmallTransactions;
    #SuspiciousIP;
    #UnusualAmount;
    #NewUserHighValue;
    #GeographicAnomaly;
};
type TransactionVelocity = {
    lastHour: Nat;
    lastDay: Nat;
    lastWeek: Nat;
    lastMonth: Nat;
    averageAmount: Amount;
    maxAmount: Amount;
};
type UserBehavior = {
    preferredCategories: [Text];
    typicalTransactionTimes: [Nat]; // Hour of day (0-23)
    commonRecipients: [Principal];
    averageTransactionAmount: Amount;
    transactionFrequency: Nat; // Transactions per day
};
type GeographicData = {
    country: ?Text;
    region: ?Text;
    city: ?Text;
    ipAddress: ?Text;
    lastKnownLocation: ?Text;
};
type SystemHealth = {
    lastCheck: Timestamp;
    errorRate: Float;
    averageResponseTime: Nat;
    activeConnections: Nat;
    systemLoad: Float;
    memoryUsage: Float;
};
// Enhanced Transaction type
type Transaction = {
    id: TransactionId;
    from: Principal;
    to: Principal;
    amount: Amount;
    timestamp: Timestamp;
    status: TransactionStatus;
    nftReceiptId: ?Nat;
    errorMessage: ?Text;
    description: ?Text;
    category: ?Text;
    tags: [Text];
    metadata: ?Blob;
    refundStatus: ?RefundStatus;
    velocity: ?TransactionVelocity;
    geographicData: ?GeographicData;
    signatures: [Principal]; // For multi-signature transactions
    scheduledFor: ?Timestamp; // For scheduled transactions
    templateId: ?Nat; // For transaction templates
    errorDetails: ?ErrorDetails;
};
type ErrorDetails = {
    code: Nat;
    category: ErrorCategory;
    timestamp: Timestamp;
    stackTrace: ?Text;
    recoveryAttempted: Bool;
    recoveryStatus: ?Text;
};
type ErrorCategory = {
    #Validation;
    #Security;
    #Network;
    #System;
    #Business;
    #Unknown;
};
// Enhanced UserBalance type
type UserBalance = {
    principal: Principal;
    balance: Amount;
    transactions: [TransactionId];
    lastTransactionTimestamp: Timestamp;
    totalTransactions: Nat;
    riskScore: Nat;
    isBlocked: Bool;
    blockReason: ?Text;
    blockExpiry: ?Timestamp;
    kycStatus: KYCStatus;
    lastKycUpdate: Timestamp;
    rateLimit: RateLimit;
    behavior: UserBehavior;
    geographicData: GeographicData;
    transactionLimits: TransactionLimits;
};
type TransactionLimits = {
    dailyLimit: Amount;
    weeklyLimit: Amount;
    monthlyLimit: Amount;
    perTransactionLimit: Amount;
    categoryLimits: [(Text, Amount)];
};
// Enhanced SystemStats type
type SystemStats = {
    totalTransactions: Nat;
    totalUsers: Nat;
    totalNFTReceipts: Nat;
    totalVolume: Amount;
    lastUpdate: Timestamp;
    activeUsers: Nat;
    blockedUsers: Nat;
    pendingKyc: Nat;
    rejectedKyc: Nat;
    totalRefunds: Nat;
    totalFraudulentTransactions: Nat;
    systemHealth: SystemHealth;
    errorStats: ErrorStats;
    velocityStats: VelocityStats;
};
type ErrorStats = {
    totalErrors: Nat;
    errorByCategory: [(ErrorCategory, Nat)];
    recentErrors: [ErrorDetails];
    errorRate: Float;
};
type VelocityStats = {
    averageTransactionVelocity: Float;
    peakTransactionVelocity: Nat;
    velocityByHour: [(Nat, Nat)]; // Hour -> Count
    velocityByCategory: [(Text, Nat)];
};
type TransactionStatus = {
    #Pending;
    #Completed;
    #Failed;
    #Fraudulent;
    #Cancelled;
    #Refunded;
};
type RefundStatus = {
    #Pending;
    #Completed;
    #Failed;
    #Rejected;
};
type KYCStatus = {
    #NotVerified;
    #Pending;
    #Verified;
    #Rejected;
};
type NFTReceipt = {
    id: Nat;
    transactionId: TransactionId;
    metadata: {
        amount: Amount;
        timestamp: Timestamp;
        from: Principal;
        to: Principal;
        description: ?Text;
        category: ?Text;
        tags: [Text];
        imageUrl: ?Text;
    };
};
type AnalyticsData = {
    dailyVolume: [(Timestamp, Amount)];
    userActivity: [(Principal, Nat)];
    transactionCategories: [(Text, Nat)];
    fraudAttempts: [(Timestamp, Nat)];
    kycStats: [(KYCStatus, Nat)];
};
// Enhanced security types
type IPBlockList = {
    ipAddress: Text;
    reason: Text;
    blockedAt: Timestamp;
    expiresAt: ?Timestamp;
    riskScore: Nat;
};
type SecurityRule = {
    id: Nat;
    name: Text;
    description: Text;
    condition: SecurityCondition;
    action: SecurityAction;
    enabled: Bool;
};
type SecurityCondition = {
    #IPRange;
    #TransactionAmount;
    #TransactionVelocity;
    #UserRiskScore;
    #GeographicLocation;
    #TimeWindow;
    #TransactionPattern;
};
type SecurityAction = {
    #BlockUser;
    #RequireKYC;
    #LimitTransaction;
    #FlagSuspicious;
    #NotifyAdmin;
};
// Enhanced analytics types
type TransactionReport = {
    period: Text; // "daily", "weekly", "monthly", "yearly"
    startTime: Timestamp;
    endTime: Timestamp;
    totalTransactions: Nat;
    totalVolume: Amount;
    averageTransactionAmount: Amount;
    transactionCategories: [(Text, Nat)];
    topRecipients: [(Principal, Nat)];
    riskMetrics: RiskMetrics;
    geographicDistribution: [(Text, Nat)];
    timeDistribution: [(Nat, Nat)]; // Hour -> Count
};
type RiskMetrics = {
    suspiciousTransactions: Nat;
    blockedTransactions: Nat;
    highRiskUsers: Nat;
    fraudAttempts: Nat;
    averageRiskScore: Float;
};
// Enhanced transaction management types
type RecurringPayment = {
    id: Nat;
    from: Principal;
    to: Principal;
    amount: Amount;
    frequency: PaymentFrequency;
    startDate: Timestamp;
    endDate: ?Timestamp;
    lastProcessed: ?Timestamp;
    status: RecurringPaymentStatus;
    description: ?Text;
    category: ?Text;
    tags: [Text];
    metadata: ?Blob;
};
type PaymentFrequency = {
    #Daily;
    #Weekly;
    #Monthly;
    #Yearly;
    #Custom;
};
type RecurringPaymentStatus = {
    #Active;
    #Paused;
    #Completed;
    #Cancelled;
    #Failed;
};
type BulkTransaction = {
    id: Nat;
    from: Principal;
    transactions: [BulkTransactionItem];
    status: BulkTransactionStatus;
    createdAt: Timestamp;
    processedAt: ?Timestamp;
    description: ?Text;
    category: ?Text;
    tags: [Text];
    metadata: ?Blob;
};
type BulkTransactionItem = {
    to: Principal;
    amount: Amount;
    description: ?Text;
    category: ?Text;
    tags: [Text];
    metadata: ?Blob;
};
type BulkTransactionStatus = {
    #Pending;
    #Processing;
    #Completed;
    #Failed;
    #PartiallyCompleted;
};
// Enhanced error handling types
type ErrorRecovery = {
    id: Nat;
    errorId: Nat;
    attemptCount: Nat;
    lastAttempt: Timestamp;
    status: RecoveryStatus;
    action: RecoveryAction;
    result: ?Text;
};
type RecoveryStatus = {
    #Pending;
    #InProgress;
    #Completed;
    #Failed;
    #Abandoned;
};
type RecoveryAction = {
    #RetryTransaction;
    #RollbackTransaction;
    #NotifyUser;
    #EscalateToAdmin;
    #BlockUser;
};
// Enhanced security types for ML-based fraud detection
type MLScore = {
    fraudProbability: Float;
    riskFactors: [RiskFactor];
    confidence: Float;
    lastUpdated: Timestamp;
};
type RiskFactor = {
    name: Text;
    score: Float;
    weight: Float;
    description: Text;
};
type IPReputation = {
    ipAddress: Text;
    reputationScore: Float;
    riskLevel: RiskLevel;
    lastActivity: Timestamp;
    activityHistory: [IPActivity];
    threatIndicators: [ThreatIndicator];
};
type RiskLevel = {
    #Low;
    #Medium;
    #High;
    #Critical;
};
type IPActivity = {
    timestamp: Timestamp;
    activityType: ActivityType;
    riskScore: Float;
    details: Text;
};
type ActivityType = {
    #LoginAttempt;
    #Transaction;
    #FailedAuth;
    #SuspiciousPattern;
    #Blocked;
};
type ThreatIndicator = {
    type = ThreatType;
    severity = Float;
    description = Text;
    firstSeen = Timestamp;
    lastSeen = Timestamp;
};
type ThreatType = {
    #Malware;
    #Botnet;
    #Proxy;
    #VPN;
    #Tor;
    #Spam;
    #Scam;
};
// Enhanced analytics types for predictive analytics
type PredictiveAnalytics = {
    transactionForecast: [TransactionForecast];
    riskPredictions: [RiskPrediction];
    userBehaviorPatterns: [BehaviorPattern];
    marketTrends: [MarketTrend];
};
type TransactionForecast = {
    timestamp: Timestamp;
    expectedVolume: Amount;
    confidence: Float;
    factors: [ForecastFactor];
};
type ForecastFactor = {
    name: Text;
    impact: Float;
    trend: Trend;
};
type Trend = {
    #Up;
    #Down;
    #Stable;
    #Volatile;
};
type RiskPrediction = {
    timestamp: Timestamp;
    riskLevel: RiskLevel;
    probability: Float;
    contributingFactors: [Text];
};
type BehaviorPattern = {
    patternType: PatternType;
    confidence: Float;
    frequency: Nat;
    lastOccurrence: Timestamp;
    details: Text;
};
type PatternType = {
    #Regular;
    #Anomaly;
    #Seasonal;
    #Trend;
};
type MarketTrend = {
    period: Text;
    trend: Trend;
    magnitude: Float;
    confidence: Float;
    indicators: [MarketIndicator];
};
type MarketIndicator = {
    name: Text;
    value: Float;
    change: Float;
    impact: Float;
};
// Enhanced transaction management types
type TransactionTemplate = {
    id: Nat;
    name: Text;
    description: Text;
    from: Principal;
    to: Principal;
    amount: Amount;
    frequency: ?PaymentFrequency;
    category: ?Text;
    tags: [Text];
    metadata: ?Blob;
    schedule: ?Schedule;
    conditions: [TemplateCondition];
    status: TemplateStatus;
};
type Schedule = {
    startDate: Timestamp;
    endDate: ?Timestamp;
    intervals: [ScheduleInterval];
    timezone: Text;
};
type ScheduleInterval = {
    type: IntervalType;
    value: Nat;
    startTime: ?Nat; // Hour of day (0-23)
    endTime: ?Nat; // Hour of day (0-23)
};
type IntervalType = {
    #Daily;
    #Weekly;
    #Monthly;
    #Custom;
};
type TemplateCondition = {
    type: ConditionType;
    value: Text;
    operator: Operator;
};
type ConditionType = {
    #Balance;
    #Time;
    #RiskScore;
    #KYCStatus;
    #Custom;
};
type Operator = {
    #Equals;
    #NotEquals;
    #GreaterThan;
    #LessThan;
    #Contains;
};
type TemplateStatus = {
    #Active;
    #Paused;
    #Expired;
    #Deleted;
};
// Enhanced error handling types
type ErrorResolution = {
    id: Nat;
    errorId: Nat;
    resolutionType: ResolutionType;
    status: ResolutionStatus;
    attempts: [ResolutionAttempt];
    finalResult: ?Text;
    resolvedAt: ?Timestamp;
};
type ResolutionType = {
    #Automatic;
    #Manual;
    #Hybrid;
    #Escalated;
};
type ResolutionStatus = {
    #Pending;
    #InProgress;
    #Resolved;
    #Failed;
    #Escalated;
};
type ResolutionAttempt = {
    timestamp: Timestamp;
    type: ResolutionType;
    result: Text;
    success: Bool;
    details: ?Text;
};
actor {
    // State variables
    private var nextTransactionId: TransactionId = 0;
    private var nextNFTId: Nat = 0;
    private var systemStats: SystemStats = {
        totalTransactions = 0;
        totalUsers = 0;
        totalNFTReceipts = 0;
        totalVolume = 0;
        lastUpdate = Time.now();
        activeUsers = 0;
        blockedUsers = 0;
        pendingKyc = 0;
        rejectedKyc = 0;
        totalRefunds = 0;
        totalFraudulentTransactions = 0;
        systemHealth = {
            lastCheck = Time.now();
            errorRate = 0.0;
            averageResponseTime = 0;
            activeConnections = 0;
            systemLoad = 0.0;
            memoryUsage = 0.0;
        };
        errorStats = {
            totalErrors = 0;
            errorByCategory = [];
            recentErrors = [];
            errorRate = 0.0;
        };
        velocityStats = {
            averageTransactionVelocity = 0.0;
            peakTransactionVelocity = 0;
            velocityByHour = [];
            velocityByCategory = [];
        };
    };
    
    // Storage for transactions and user balances
    private let transactions = HashMap.HashMap<TransactionId, Transaction>(0, Nat.equal, Hash.hash);
    private let userBalances = HashMap.HashMap<Principal, UserBalance>(0, Principal.equal, Principal.hash);
    private let nftReceipts = HashMap.HashMap<Nat, NFTReceipt>(0, Nat.equal, Hash.hash);
    private let analyticsData = Buffer.Buffer<AnalyticsData>(30); // Store 30 days of analytics
    
    // New state variables for enhanced features
    private let ipBlockList = HashMap.HashMap<Text, IPBlockList>(0, Text.equal, Text.hash);
    private let securityRules = HashMap.HashMap<Nat, SecurityRule>(0, Nat.equal, Hash.hash);
    private let recurringPayments = HashMap.HashMap<Nat, RecurringPayment>(0, Nat.equal, Hash.hash);
    private let bulkTransactions = HashMap.HashMap<Nat, BulkTransaction>(0, Nat.equal, Hash.hash);
    private let errorRecoveries = HashMap.HashMap<Nat, ErrorRecovery>(0, Nat.equal, Hash.hash);
    
    private var nextRecurringPaymentId: Nat = 0;
    private var nextBulkTransactionId: Nat = 0;
    private var nextErrorRecoveryId: Nat = 0;
    private var nextSecurityRuleId: Nat = 0;
    
    // New state variables for enhanced features
    private let mlScores = HashMap.HashMap<Principal, MLScore>(0, Principal.equal, Principal.hash);
    private let ipReputations = HashMap.HashMap<Text, IPReputation>(0, Text.equal, Text.hash);
    private let predictiveAnalytics = Buffer.Buffer<PredictiveAnalytics>(30);
    private let transactionTemplates = HashMap.HashMap<Nat, TransactionTemplate>(0, Nat.equal, Hash.hash);
    private let errorResolutions = HashMap.HashMap<Nat, ErrorResolution>(0, Nat.equal, Hash.hash);
    
    private var nextTemplateId: Nat = 0;
    private var nextResolutionId: Nat = 0;
    
    // Security thresholds
    private let MAX_TRANSACTION_AMOUNT = 1_000_000; // 1 ICP
    private let MIN_TRANSACTION_INTERVAL = 60_000_000_000; // 1 minute in nanoseconds
    private let MAX_DAILY_TRANSACTIONS = 100;
    private let MAX_DAILY_VOLUME = 10_000_000; // 10 ICP
    private let MAX_RISK_SCORE = 100;
    private let BLOCK_DURATION = 86_400_000_000_000; // 24 hours in nanoseconds
    private let KYC_EXPIRY = 31 * 86_400_000_000_000; // 31 days in nanoseconds
    
    // Core payment processing function
    public shared(msg) func processPayment(to: Principal, amount: Amount, description: ?Text, category: ?Text, tags: [Text], metadata: ?Blob) : async Result.Result<TransactionId, Text> {
        let caller = msg.caller;
        
        // Check if user is blocked
        switch (await checkUserStatus(caller)) {
            case (#ok()) {};
            case (#err(e)) { return #err(e) };
        };
        
        // Validate amount
        if (amount == 0) {
            return #err("Amount must be greater than 0");
        };
        
        // Check if sender and receiver are different
        if (Principal.equal(caller, to)) {
            return #err("Cannot send payment to yourself");
        };
        
        // Check fraud detection
        switch (await checkFraudDetection(caller, amount)) {
            case (#ok()) {};
            case (#err(e)) {
                await updateUserRiskScore(caller, 10); // Increase risk score
                return #err("Transaction flagged as potentially fraudulent: " # e);
            };
        };
        
        // Create transaction
        let transaction: Transaction = {
            id = nextTransactionId;
            from = caller;
            to = to;
            amount = amount;
            timestamp = Time.now();
            status = #Pending;
            nftReceiptId = null;
            errorMessage = null;
            description = description;
            category = category;
            tags = tags;
            metadata = metadata;
            refundStatus = null;
            velocity = null;
            geographicData = null;
            signatures = [];
            scheduledFor = null;
            templateId = null;
            errorDetails = null;
        };
        
        // Update state
        transactions.put(nextTransactionId, transaction);
        nextTransactionId += 1;
        
        // Process the payment
        switch (await updateBalances(caller, to, amount)) {
            case (#ok()) {
                // Create NFT receipt
                let nftReceipt = await createNFTReceipt(transaction);
                
                // Update transaction with receipt
                let updatedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = #Completed;
                    nftReceiptId = ?nftReceipt.id;
                    errorMessage = null;
                    description = description;
                    category = category;
                    tags = tags;
                    metadata = metadata;
                    refundStatus = null;
                    velocity = null;
                    geographicData = null;
                    signatures = [];
                    scheduledFor = null;
                    templateId = null;
                    errorDetails = null;
                };
                
                transactions.put(transaction.id, updatedTransaction);
                await updateSystemStats(amount);
                await updateAnalytics(transaction);
                await updateUserRiskScore(caller, -5); // Decrease risk score for successful transaction
                #ok(transaction.id)
            };
            case (#err(e)) {
                let failedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = #Failed;
                    nftReceiptId = null;
                    errorMessage = ?e;
                    description = description;
                    category = category;
                    tags = tags;
                    metadata = metadata;
                    refundStatus = null;
                    velocity = null;
                    geographicData = null;
                    signatures = [];
                    scheduledFor = null;
                    templateId = null;
                    errorDetails = null;
                };
                
                transactions.put(transaction.id, failedTransaction);
                await updateUserRiskScore(caller, 5); // Increase risk score for failed transaction
                #err(e)
            };
        };
    };
    
    // Check user status
    private func checkUserStatus(user: Principal) : async Result.Result<(), Text> {
        switch (userBalances.get(user)) {
            case (?balance) {
                if (balance.isBlocked) {
                    switch (balance.blockExpiry) {
                        case (?expiry) {
                            if (Time.now() < expiry) {
                                #err("Account is blocked: " # Option.unwrap(balance.blockReason))
                            } else {
                                // Unblock user if expiry has passed
                                let updatedBalance = {
                                    principal = balance.principal;
                                    balance = balance.balance;
                                    transactions = balance.transactions;
                                    lastTransactionTimestamp = balance.lastTransactionTimestamp;
                                    totalTransactions = balance.totalTransactions;
                                    riskScore = balance.riskScore;
                                    isBlocked = false;
                                    blockReason = null;
                                    blockExpiry = null;
                                    kycStatus = balance.kycStatus;
                                    lastKycUpdate = balance.lastKycUpdate;
                                    rateLimit = balance.rateLimit;
                                    behavior = balance.behavior;
                                    geographicData = balance.geographicData;
                                    transactionLimits = balance.transactionLimits;
                                };
                                userBalances.put(user, updatedBalance);
                                #ok()
                            }
                        };
                        case null { #ok() };
                    }
                } else {
                    #ok()
                }
            };
            case null { #ok() };
        };
    };
    
    // Update user risk score
    private func updateUserRiskScore(user: Principal, delta: Int) : async () {
        switch (userBalances.get(user)) {
            case (?balance) {
                let newScore = if (delta > 0) {
                    Nat.min(balance.riskScore + Nat.abs(delta), MAX_RISK_SCORE)
                } else {
                    if (balance.riskScore > Nat.abs(delta)) {
                        balance.riskScore - Nat.abs(delta)
                    } else {
                        0
                    }
                };
                
                let updatedBalance = {
                    principal = balance.principal;
                    balance = balance.balance;
                    transactions = balance.transactions;
                    lastTransactionTimestamp = balance.lastTransactionTimestamp;
                    totalTransactions = balance.totalTransactions;
                    riskScore = newScore;
                    isBlocked = balance.isBlocked;
                    blockReason = balance.blockReason;
                    blockExpiry = balance.blockExpiry;
                    kycStatus = balance.kycStatus;
                    lastKycUpdate = balance.lastKycUpdate;
                    rateLimit = balance.rateLimit;
                    behavior = balance.behavior;
                    geographicData = balance.geographicData;
                    transactionLimits = balance.transactionLimits;
                };
                
                userBalances.put(user, updatedBalance);
                
                // Block user if risk score is too high
                if (newScore >= 80) {
                    let blockedBalance = {
                        principal = updatedBalance.principal;
                        balance = updatedBalance.balance;
                        transactions = updatedBalance.transactions;
                        lastTransactionTimestamp = updatedBalance.lastTransactionTimestamp;
                        totalTransactions = updatedBalance.totalTransactions;
                        riskScore = updatedBalance.riskScore;
                        isBlocked = true;
                        blockReason = ?"High risk score";
                        blockExpiry = ?(Time.now() + BLOCK_DURATION);
                        kycStatus = updatedBalance.kycStatus;
                        lastKycUpdate = updatedBalance.lastKycUpdate;
                        rateLimit = updatedBalance.rateLimit;
                        behavior = updatedBalance.behavior;
                        geographicData = updatedBalance.geographicData;
                        transactionLimits = updatedBalance.transactionLimits;
                    };
                    userBalances.put(user, blockedBalance);
                };
            };
            case null {};
        };
    };
    
    // Update analytics data
    private func updateAnalytics(transaction: Transaction) : async () {
        let currentData = if (Buffer.size(analyticsData) > 0) {
            Buffer.get(analyticsData, Buffer.size(analyticsData) - 1)
        } else {
            {
                dailyVolume = [];
                userActivity = [];
                transactionCategories = [];
                fraudAttempts = [];
                kycStats = [];
            }
        };
        
        // Update daily volume
        let today = Time.now() / 86_400_000_000_000 * 86_400_000_000_000;
        let updatedDailyVolume = Array.filter<(Timestamp, Amount)>(
            currentData.dailyVolume,
            func((t, _)) { t == today }
        );
        
        let newDailyVolume = switch (Array.size(updatedDailyVolume)) {
            case (0) { [(today, transaction.amount)] };
            case (_) {
                let (_, currentAmount) = Array.get(updatedDailyVolume, 0);
                [(today, currentAmount + transaction.amount)]
            };
        };
        
        // Update user activity
        let updatedUserActivity = Array.filter<(Principal, Nat)>(
            currentData.userActivity,
            func((p, _)) { Principal.equal(p, transaction.from) }
        );
        
        let newUserActivity = switch (Array.size(updatedUserActivity)) {
            case (0) { [(transaction.from, 1)] };
            case (_) {
                let (_, count) = Array.get(updatedUserActivity, 0);
                [(transaction.from, count + 1)]
            };
        };
        
        // Update transaction categories
        let updatedCategories = switch (transaction.category) {
            case (?cat) {
                Array.filter<(Text, Nat)>(
                    currentData.transactionCategories,
                    func((c, _)) { c == cat }
                )
            };
            case null { [] };
        };
        
        let newCategories = switch (transaction.category) {
            case (?cat) {
                switch (Array.size(updatedCategories)) {
                    case (0) { [(cat, 1)] };
                    case (_) {
                        let (_, count) = Array.get(updatedCategories, 0);
                        [(cat, count + 1)]
                    };
                }
            };
            case null { [] };
        };
        
        // Update fraud attempts
        let updatedFraudAttempts = Array.filter<(Timestamp, Nat)>(
            currentData.fraudAttempts,
            func((t, _)) { t == today }
        );
        
        let newFraudAttempts = switch (transaction.status) {
            case (#Fraudulent) {
                switch (Array.size(updatedFraudAttempts)) {
                    case (0) { [(today, 1)] };
                    case (_) {
                        let (_, count) = Array.get(updatedFraudAttempts, 0);
                        [(today, count + 1)]
                    };
                }
            };
            case (_) { [] };
        };
        
        // Update KYC stats
        let updatedKycStats = switch (userBalances.get(transaction.from)) {
            case (?balance) {
                Array.filter<(KYCStatus, Nat)>(
                    currentData.kycStats,
                    func((s, _)) { s == balance.kycStatus }
                )
            };
            case null { [] };
        };
        
        let newKycStats = switch (userBalances.get(transaction.from)) {
            case (?balance) {
                switch (Array.size(updatedKycStats)) {
                    case (0) { [(balance.kycStatus, 1)] };
                    case (_) {
                        let (_, count) = Array.get(updatedKycStats, 0);
                        [(balance.kycStatus, count + 1)]
                    };
                }
            };
            case null { [] };
        };
        
        // Update analytics buffer
        let newData = {
            dailyVolume = newDailyVolume;
            userActivity = newUserActivity;
            transactionCategories = newCategories;
            fraudAttempts = newFraudAttempts;
            kycStats = newKycStats;
        };
        
        if (Buffer.size(analyticsData) >= 30) {
            Buffer.removeLast(analyticsData);
        };
        Buffer.add(analyticsData, newData);
    };
    
    // Request refund
    public shared(msg) func requestRefund(transactionId: TransactionId, reason: Text) : async Result.Result<(), Text> {
        let caller = msg.caller;
        
        switch (transactions.get(transactionId)) {
            case (?transaction) {
                if (not Principal.equal(caller, transaction.from)) {
                    return #err("Only the sender can request a refund");
                };
                
                if (transaction.status != #Completed) {
                    return #err("Only completed transactions can be refunded");
                };
                
                let updatedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = #Pending;
                    nftReceiptId = transaction.nftReceiptId;
                    errorMessage = null;
                    description = transaction.description;
                    category = transaction.category;
                    tags = transaction.tags;
                    metadata = transaction.metadata;
                    refundStatus = ?#Pending;
                    velocity = transaction.velocity;
                    geographicData = transaction.geographicData;
                    signatures = transaction.signatures;
                    scheduledFor = transaction.scheduledFor;
                    templateId = transaction.templateId;
                    errorDetails = transaction.errorDetails;
                };
                
                transactions.put(transactionId, updatedTransaction);
                #ok()
            };
            case null {
                #err("Transaction not found")
            };
        };
    };
    
    // Process refund
    public shared(msg) func processRefund(transactionId: TransactionId, approved: Bool) : async Result.Result<(), Text> {
        // Only the canister controller can process refunds
        if (not Principal.equal(msg.caller, Principal.fromActor(actor {}))) {
            return #err("Unauthorized");
        };
        
        switch (transactions.get(transactionId)) {
            case (?transaction) {
                if (transaction.status != #Pending or transaction.refundStatus != ?#Pending) {
                    return #err("Invalid refund request");
                };
                
                if (approved) {
                    // Process the refund
                    switch (await updateBalances(transaction.to, transaction.from, transaction.amount)) {
                        case (#ok()) {
                            let updatedTransaction = {
                                id = transaction.id;
                                from = transaction.from;
                                to = transaction.to;
                                amount = transaction.amount;
                                timestamp = transaction.timestamp;
                                status = #Refunded;
                                nftReceiptId = transaction.nftReceiptId;
                                errorMessage = null;
                                description = transaction.description;
                                category = transaction.category;
                                tags = transaction.tags;
                                metadata = transaction.metadata;
                                refundStatus = ?#Completed;
                                velocity = transaction.velocity;
                                geographicData = transaction.geographicData;
                                signatures = transaction.signatures;
                                scheduledFor = transaction.scheduledFor;
                                templateId = transaction.templateId;
                                errorDetails = transaction.errorDetails;
                            };
                            
                            transactions.put(transactionId, updatedTransaction);
                            systemStats := {
                                totalTransactions = systemStats.totalTransactions;
                                totalUsers = systemStats.totalUsers;
                                totalNFTReceipts = systemStats.totalNFTReceipts;
                                totalVolume = systemStats.totalVolume;
                                lastUpdate = Time.now();
                                activeUsers = systemStats.activeUsers;
                                blockedUsers = systemStats.blockedUsers;
                                pendingKyc = systemStats.pendingKyc;
                                rejectedKyc = systemStats.rejectedKyc;
                                totalRefunds = systemStats.totalRefunds + 1;
                                totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
                                systemHealth = systemStats.systemHealth;
                                errorStats = systemStats.errorStats;
                                velocityStats = systemStats.velocityStats;
                            };
                            #ok()
                        };
                        case (#err(e)) {
                            let failedTransaction = {
                                id = transaction.id;
                                from = transaction.from;
                                to = transaction.to;
                                amount = transaction.amount;
                                timestamp = transaction.timestamp;
                                status = #Failed;
                                nftReceiptId = transaction.nftReceiptId;
                                errorMessage = ?e;
                                description = transaction.description;
                                category = transaction.category;
                                tags = transaction.tags;
                                metadata = transaction.metadata;
                                refundStatus = ?#Failed;
                                velocity = transaction.velocity;
                                geographicData = transaction.geographicData;
                                signatures = transaction.signatures;
                                scheduledFor = transaction.scheduledFor;
                                templateId = transaction.templateId;
                                errorDetails = transaction.errorDetails;
                            };
                            
                            transactions.put(transactionId, failedTransaction);
                            #err(e)
                        };
                    };
                } else {
                    let rejectedTransaction = {
                        id = transaction.id;
                        from = transaction.from;
                        to = transaction.to;
                        amount = transaction.amount;
                        timestamp = transaction.timestamp;
                        status = #Completed;
                        nftReceiptId = transaction.nftReceiptId;
                        errorMessage = null;
                        description = transaction.description;
                        category = transaction.category;
                        tags = transaction.tags;
                        metadata = transaction.metadata;
                        refundStatus = ?#Rejected;
                        velocity = transaction.velocity;
                        geographicData = transaction.geographicData;
                        signatures = transaction.signatures;
                        scheduledFor = transaction.scheduledFor;
                        templateId = transaction.templateId;
                        errorDetails = transaction.errorDetails;
                    };
                    
                    transactions.put(transactionId, rejectedTransaction);
                    #ok()
                };
            };
            case null {
                #err("Transaction not found")
            };
        };
    };
    
    // Cancel transaction
    public shared(msg) func cancelTransaction(transactionId: TransactionId) : async Result.Result<(), Text> {
        let caller = msg.caller;
        
        switch (transactions.get(transactionId)) {
            case (?transaction) {
                if (not Principal.equal(caller, transaction.from)) {
                    return #err("Only the sender can cancel the transaction");
                };
                
                if (transaction.status != #Pending) {
                    return #err("Only pending transactions can be cancelled");
                };
                
                let updatedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = #Cancelled;
                    nftReceiptId = transaction.nftReceiptId;
                    errorMessage = null;
                    description = transaction.description;
                    category = transaction.category;
                    tags = transaction.tags;
                    metadata = transaction.metadata;
                    refundStatus = null;
                    velocity = transaction.velocity;
                    geographicData = transaction.geographicData;
                    signatures = transaction.signatures;
                    scheduledFor = transaction.scheduledFor;
                    templateId = transaction.templateId;
                    errorDetails = transaction.errorDetails;
                };
                
                transactions.put(transactionId, updatedTransaction);
                #ok()
            };
            case null {
                #err("Transaction not found")
            };
        };
    };
    
    // Update KYC status
    public shared(msg) func updateKYCStatus(user: Principal, status: KYCStatus) : async Result.Result<(), Text> {
        // Only the canister controller can update KYC status
        if (not Principal.equal(msg.caller, Principal.fromActor(actor {}))) {
            return #err("Unauthorized");
        };
        
        switch (userBalances.get(user)) {
            case (?balance) {
                let updatedBalance = {
                    principal = balance.principal;
                    balance = balance.balance;
                    transactions = balance.transactions;
                    lastTransactionTimestamp = balance.lastTransactionTimestamp;
                    totalTransactions = balance.totalTransactions;
                    riskScore = balance.riskScore;
                    isBlocked = balance.isBlocked;
                    blockReason = balance.blockReason;
                    blockExpiry = balance.blockExpiry;
                    kycStatus = status;
                    lastKycUpdate = Time.now();
                    rateLimit = balance.rateLimit;
                    behavior = balance.behavior;
                    geographicData = balance.geographicData;
                    transactionLimits = balance.transactionLimits;
                };
                
                userBalances.put(user, updatedBalance);
                
                // Update system stats
                systemStats := {
                    totalTransactions = systemStats.totalTransactions;
                    totalUsers = systemStats.totalUsers;
                    totalNFTReceipts = systemStats.totalNFTReceipts;
                    totalVolume = systemStats.totalVolume;
                    lastUpdate = Time.now();
                    activeUsers = systemStats.activeUsers;
                    blockedUsers = systemStats.blockedUsers;
                    pendingKyc = if (status == #Pending) { systemStats.pendingKyc + 1 } else { systemStats.pendingKyc };
                    rejectedKyc = if (status == #Rejected) { systemStats.rejectedKyc + 1 } else { systemStats.rejectedKyc };
                    totalRefunds = systemStats.totalRefunds;
                    totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
                    systemHealth = systemStats.systemHealth;
                    errorStats = systemStats.errorStats;
                    velocityStats = systemStats.velocityStats;
                };
                
                #ok()
            };
            case null {
                #err("User not found")
            };
        };
    };
    
    // Query functions
    public query func getTransaction(id: TransactionId) : async ?Transaction {
        transactions.get(id)
    };
    
    public query func getBalance(user: Principal) : async ?Amount {
        switch (userBalances.get(user)) {
            case (?balance) { ?balance.balance };
            case null { null };
        }
    };
    
    public query func getNFTReceipt(id: Nat) : async ?NFTReceipt {
        nftReceipts.get(id)
    };
    
    public query func getUserTransactions(user: Principal) : async [Transaction] {
        switch (userBalances.get(user)) {
            case (?balance) {
                Array.mapFilter<TransactionId, Transaction>(
                    balance.transactions,
                    func(id) { transactions.get(id) }
                )
            };
            case null { [] };
        }
    };
    
    public query func getSystemStats() : async SystemStats {
        systemStats
    };
    
    public query func getUserStats(user: Principal) : async ?UserBalance {
        userBalances.get(user)
    };
    
    public query func getTransactionHistory(user: Principal, limit: ?Nat) : async [Transaction] {
        switch (userBalances.get(user)) {
            case (?balance) {
                let allTransactions = Array.mapFilter<TransactionId, Transaction>(
                    balance.transactions,
                    func(id) { transactions.get(id) }
                );
                
                switch (limit) {
                    case (?l) {
                        let size = Array.size(allTransactions);
                        if (size <= l) {
                            allTransactions
                        } else {
                            Array.tabulate<Transaction>(
                                l,
                                func(i) { allTransactions[size - 1 - i] }
                            )
                        }
                    };
                    case null { allTransactions };
                }
            };
            case null { [] };
        }
    };
    
    // New query functions
    public query func getAnalyticsData(days: ?Nat) : async AnalyticsData {
        let requestedDays = switch (days) {
            case (?d) { Nat.min(d, Buffer.size(analyticsData)) };
            case null { Buffer.size(analyticsData) };
        };
        
        let startIndex = if (Buffer.size(analyticsData) > requestedDays) {
            Buffer.size(analyticsData) - requestedDays
        } else {
            0
        };
        
        let result = Buffer.Buffer<AnalyticsData>(requestedDays);
        for (i in Iter.range(startIndex, Buffer.size(analyticsData) - 1)) {
            Buffer.add(result, Buffer.get(analyticsData, i));
        };
        
        {
            dailyVolume = Buffer.toArray(result);
            userActivity = [];
            transactionCategories = [];
            fraudAttempts = [];
            kycStats = [];
        }
    };
    
    public query func getRefundRequests() : async [(TransactionId, Transaction)] {
        let refundRequests = Buffer.Buffer<(TransactionId, Transaction)>(0);
        for ((id, tx) in transactions.entries()) {
            if (tx.status == #Pending and tx.refundStatus == ?#Pending) {
                Buffer.add(refundRequests, (id, tx));
            };
        };
        Buffer.toArray(refundRequests)
    };
    
    public query func getPendingTransactions() : async [(TransactionId, Transaction)] {
        let pendingTransactions = Buffer.Buffer<(TransactionId, Transaction)>(0);
        for ((id, tx) in transactions.entries()) {
            if (tx.status == #Pending) {
                Buffer.add(pendingTransactions, (id, tx));
            };
        };
        Buffer.toArray(pendingTransactions)
    };
    
    // Rate limiting functions
    private func checkRateLimit(user: Principal) : async Result.Result<(), Text> {
        switch (userBalances.get(user)) {
            case (?balance) {
                let now = Time.now();
                let rateLimit = balance.rateLimit;
                
                // Reset counters if needed
                if (now - rateLimit.lastReset > 60_000_000_000) { // 1 minute
                    let updatedRateLimit = {
                        requestsPerMinute = rateLimit.requestsPerMinute;
                        requestsPerHour = rateLimit.requestsPerHour;
                        requestsPerDay = rateLimit.requestsPerDay;
                        lastReset = now;
                        requestCount = 0;
                    };
                    
                    let updatedBalance = {
                        principal = balance.principal;
                        balance = balance.balance;
                        transactions = balance.transactions;
                        lastTransactionTimestamp = balance.lastTransactionTimestamp;
                        totalTransactions = balance.totalTransactions;
                        riskScore = balance.riskScore;
                        isBlocked = balance.isBlocked;
                        blockReason = balance.blockReason;
                        blockExpiry = balance.blockExpiry;
                        kycStatus = balance.kycStatus;
                        lastKycUpdate = balance.lastKycUpdate;
                        rateLimit = updatedRateLimit;
                        behavior = balance.behavior;
                        geographicData = balance.geographicData;
                        transactionLimits = balance.transactionLimits;
                    };
                    
                    userBalances.put(user, updatedBalance);
                    #ok()
                } else if (rateLimit.requestCount >= rateLimit.requestsPerMinute) {
                    #err("Rate limit exceeded. Please try again later.")
                } else {
                    let updatedRateLimit = {
                        requestsPerMinute = rateLimit.requestsPerMinute;
                        requestsPerHour = rateLimit.requestsPerHour;
                        requestsPerDay = rateLimit.requestsPerDay;
                        lastReset = rateLimit.lastReset;
                        requestCount = rateLimit.requestCount + 1;
                    };
                    
                    let updatedBalance = {
                        principal = balance.principal;
                        balance = balance.balance;
                        transactions = balance.transactions;
                        lastTransactionTimestamp = balance.lastTransactionTimestamp;
                        totalTransactions = balance.totalTransactions;
                        riskScore = balance.riskScore;
                        isBlocked = balance.isBlocked;
                        blockReason = balance.blockReason;
                        blockExpiry = balance.blockExpiry;
                        kycStatus = balance.kycStatus;
                        lastKycUpdate = balance.lastKycUpdate;
                        rateLimit = updatedRateLimit;
                        behavior = balance.behavior;
                        geographicData = balance.geographicData;
                        transactionLimits = balance.transactionLimits;
                    };
                    
                    userBalances.put(user, updatedBalance);
                    #ok()
                }
            };
            case null { #ok() };
        }
    };
    
    // Enhanced fraud detection
    private func checkFraudDetection(user: Principal, amount: Amount) : async Result.Result<(), Text> {
        switch (userBalances.get(user)) {
            case (?balance) {
                // Check transaction velocity
                let velocity = balance.behavior.transactionFrequency;
                if (velocity > MAX_DAILY_TRANSACTIONS) {
                    return #err("Transaction velocity exceeds daily limit");
                };
                
                // Check amount against limits
                if (amount > balance.transactionLimits.perTransactionLimit) {
                    return #err("Transaction amount exceeds per-transaction limit");
                };
                
                // Check geographic anomalies
                switch (balance.geographicData.ipAddress) {
                    case (?ip) {
                        // Check if IP is in known suspicious list
                        if (await isSuspiciousIP(ip)) {
                            return #err("Suspicious IP address detected");
                        };
                    };
                    case null {};
                };
                
                // Check for unusual transaction patterns
                if (await hasUnusualPattern(user, amount)) {
                    return #err("Unusual transaction pattern detected");
                };
                
                #ok()
            };
            case null { #ok() };
        }
    };
    
    // Multi-signature transaction support
    public shared(msg) func createMultiSigTransaction(
        to: Principal,
        amount: Amount,
        requiredSignatures: Nat,
        signers: [Principal],
        description: ?Text,
        category: ?Text,
        tags: [Text],
        metadata: ?Blob
    ) : async Result.Result<TransactionId, Text> {
        let caller = msg.caller;
        
        // Validate signers
        if (Array.size(signers) < requiredSignatures) {
            return #err("Insufficient number of signers");
        };
        
        // Create transaction
        let transaction: Transaction = {
            id = nextTransactionId;
            from = caller;
            to = to;
            amount = amount;
            timestamp = Time.now();
            status = #Pending;
            nftReceiptId = null;
            errorMessage = null;
            description = description;
            category = category;
            tags = tags;
            metadata = metadata;
            refundStatus = null;
            velocity = null;
            geographicData = null;
            signatures = [caller];
            scheduledFor = null;
            templateId = null;
            errorDetails = null;
        };
        
        transactions.put(nextTransactionId, transaction);
        nextTransactionId += 1;
        
        #ok(transaction.id)
    };
    
    // Sign a multi-signature transaction
    public shared(msg) func signTransaction(transactionId: TransactionId) : async Result.Result<(), Text> {
        let caller = msg.caller;
        
        switch (transactions.get(transactionId)) {
            case (?transaction) {
                if (transaction.status != #Pending) {
                    return #err("Transaction is not pending");
                };
                
                if (Array.size(transaction.signatures) >= requiredSignatures) {
                    return #err("Transaction already has sufficient signatures");
                };
                
                if (Array.find<Principal>(transaction.signatures, func(p) { Principal.equal(p, caller) }) != null) {
                    return #err("Already signed by this user");
                };
                
                let updatedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = transaction.status;
                    nftReceiptId = transaction.nftReceiptId;
                    errorMessage = transaction.errorMessage;
                    description = transaction.description;
                    category = transaction.category;
                    tags = transaction.tags;
                    metadata = transaction.metadata;
                    refundStatus = transaction.refundStatus;
                    velocity = transaction.velocity;
                    geographicData = transaction.geographicData;
                    signatures = Array.append(transaction.signatures, [caller]);
                    scheduledFor = transaction.scheduledFor;
                    templateId = transaction.templateId;
                    errorDetails = transaction.errorDetails;
                };
                
                transactions.put(transactionId, updatedTransaction);
                
                // Process transaction if we have enough signatures
                if (Array.size(updatedTransaction.signatures) >= requiredSignatures) {
                    await processPayment(to, amount, description, category, tags, metadata);
                };
                
                #ok()
            };
            case null {
                #err("Transaction not found")
            };
        }
    };
    
    // Schedule a transaction
    public shared(msg) func scheduleTransaction(
        to: Principal,
        amount: Amount,
        scheduledTime: Timestamp,
        description: ?Text,
        category: ?Text,
        tags: [Text],
        metadata: ?Blob
    ) : async Result.Result<TransactionId, Text> {
        let caller = msg.caller;
        
        if (scheduledTime <= Time.now()) {
            return #err("Scheduled time must be in the future");
        };
        
        let transaction: Transaction = {
            id = nextTransactionId;
            from = caller;
            to = to;
            amount = amount;
            timestamp = Time.now();
            status = #Pending;
            nftReceiptId = null;
            errorMessage = null;
            description = description;
            category = category;
            tags = tags;
            metadata = metadata;
            refundStatus = null;
            velocity = null;
            geographicData = null;
            signatures = [];
            scheduledFor = ?scheduledTime;
            templateId = null;
            errorDetails = null;
        };
        
        transactions.put(nextTransactionId, transaction);
        nextTransactionId += 1;
        
        #ok(transaction.id)
    };
    
    // Enhanced error handling
    private func handleError(
        transactionId: TransactionId,
        error: Text,
        category: ErrorCategory,
        stackTrace: ?Text
    ) : async () {
        let errorDetails: ErrorDetails = {
            code = 0; // TODO: Implement error code mapping
            category = category;
            timestamp = Time.now();
            stackTrace = stackTrace;
            recoveryAttempted = false;
            recoveryStatus = null;
        };
        
        switch (transactions.get(transactionId)) {
            case (?transaction) {
                let updatedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = #Failed;
                    nftReceiptId = transaction.nftReceiptId;
                    errorMessage = ?error;
                    description = transaction.description;
                    category = transaction.category;
                    tags = transaction.tags;
                    metadata = transaction.metadata;
                    refundStatus = transaction.refundStatus;
                    velocity = transaction.velocity;
                    geographicData = transaction.geographicData;
                    signatures = transaction.signatures;
                    scheduledFor = transaction.scheduledFor;
                    templateId = transaction.templateId;
                    errorDetails = ?errorDetails;
                };
                
                transactions.put(transactionId, updatedTransaction);
                
                // Update system error stats
                systemStats := {
                    totalTransactions = systemStats.totalTransactions;
                    totalUsers = systemStats.totalUsers;
                    totalNFTReceipts = systemStats.totalNFTReceipts;
                    totalVolume = systemStats.totalVolume;
                    lastUpdate = Time.now();
                    activeUsers = systemStats.activeUsers;
                    blockedUsers = systemStats.blockedUsers;
                    pendingKyc = systemStats.pendingKyc;
                    rejectedKyc = systemStats.rejectedKyc;
                    totalRefunds = systemStats.totalRefunds;
                    totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
                    systemHealth = systemStats.systemHealth;
                    errorStats = {
                        totalErrors = systemStats.errorStats.totalErrors + 1;
                        errorByCategory = Array.append(
                            systemStats.errorStats.errorByCategory,
                            [(category, 1)]
                        );
                        recentErrors = Array.append(
                            systemStats.errorStats.recentErrors,
                            [errorDetails]
                        );
                        errorRate = Float.fromInt(systemStats.errorStats.totalErrors + 1) / Float.fromInt(systemStats.totalTransactions);
                    };
                    velocityStats = systemStats.velocityStats;
                };
            };
            case null {};
        };
    };
    
    // System health monitoring
    private func updateSystemHealth() : async () {
        let currentTime = Time.now();
        let health = systemStats.systemHealth;
        
        // Update system health metrics
        systemStats := {
            totalTransactions = systemStats.totalTransactions;
            totalUsers = systemStats.totalUsers;
            totalNFTReceipts = systemStats.totalNFTReceipts;
            totalVolume = systemStats.totalVolume;
            lastUpdate = currentTime;
            activeUsers = systemStats.activeUsers;
            blockedUsers = systemStats.blockedUsers;
            pendingKyc = systemStats.pendingKyc;
            rejectedKyc = systemStats.rejectedKyc;
            totalRefunds = systemStats.totalRefunds;
            totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
            systemHealth = {
                lastCheck = currentTime;
                errorRate = systemStats.errorStats.errorRate;
                averageResponseTime = 0; // TODO: Implement response time tracking
                activeConnections = 0; // TODO: Implement connection tracking
                systemLoad = 0.0; // TODO: Implement system load tracking
                memoryUsage = 0.0; // TODO: Implement memory usage tracking
            };
            errorStats = systemStats.errorStats;
            velocityStats = systemStats.velocityStats;
        };
    };
    
    // Enhanced security functions
    public shared(msg) func addSecurityRule(rule: SecurityRule) : async Result.Result<Nat, Text> {
        // Only the canister controller can add security rules
        if (not Principal.equal(msg.caller, Principal.fromActor(actor {}))) {
            return #err("Unauthorized");
        };
        
        let ruleId = nextSecurityRuleId;
        securityRules.put(ruleId, rule);
        nextSecurityRuleId += 1;
        
        #ok(ruleId)
    };
    
    public shared(msg) func blockIP(ip: Text, reason: Text, duration: ?Nat) : async Result.Result<(), Text> {
        // Only the canister controller can block IPs
        if (not Principal.equal(msg.caller, Principal.fromActor(actor {}))) {
            return #err("Unauthorized");
        };
        
        let blockList: IPBlockList = {
            ipAddress = ip;
            reason = reason;
            blockedAt = Time.now();
            expiresAt = switch (duration) {
                case (?d) { ?(Time.now() + Int.abs(d)) };
                case null { null };
            };
            riskScore = 100;
        };
        
        ipBlockList.put(ip, blockList);
        #ok()
    };
    
    // Enhanced analytics functions
    public query func generateTransactionReport(
        period: Text,
        startTime: Timestamp,
        endTime: Timestamp
    ) : async Result.Result<TransactionReport, Text> {
        let transactions = Buffer.Buffer<Transaction>(0);
        
        // Collect transactions within the time period
        for ((_, tx) in transactions.entries()) {
            if (tx.timestamp >= startTime and tx.timestamp <= endTime) {
                Buffer.add(transactions, tx);
            };
        };
        
        // Calculate metrics
        let totalTransactions = Buffer.size(transactions);
        let totalVolume = Array.foldLeft<Transaction, Amount>(
            Buffer.toArray(transactions),
            0,
            func(acc, tx) { acc + tx.amount }
        );
        
        let averageAmount = if (totalTransactions > 0) {
            totalVolume / totalTransactions
        } else {
            0
        };
        
        // Calculate category distribution
        let categoryCounts = HashMap.HashMap<Text, Nat>(0, Text.equal, Text.hash);
        for (tx in Buffer.toArray(transactions).vals()) {
            switch (tx.category) {
                case (?cat) {
                    let current = switch (categoryCounts.get(cat)) {
                        case (?count) { count };
                        case null { 0 };
                    };
                    categoryCounts.put(cat, current + 1);
                };
                case null {};
            };
        };
        
        // Calculate recipient distribution
        let recipientCounts = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
        for (tx in Buffer.toArray(transactions).vals()) {
            let current = switch (recipientCounts.get(tx.to)) {
                case (?count) { count };
                case null { 0 };
            };
            recipientCounts.put(tx.to, current + 1);
        };
        
        // Calculate risk metrics
        let riskMetrics: RiskMetrics = {
            suspiciousTransactions = 0;
            blockedTransactions = 0;
            highRiskUsers = 0;
            fraudAttempts = 0;
            averageRiskScore = 0.0;
        };
        
        // Calculate geographic distribution
        let geoCounts = HashMap.HashMap<Text, Nat>(0, Text.equal, Text.hash);
        for (tx in Buffer.toArray(transactions).vals()) {
            switch (tx.geographicData) {
                case (?geo) {
                    switch (geo.country) {
                        case (?country) {
                            let current = switch (geoCounts.get(country)) {
                                case (?count) { count };
                                case null { 0 };
                            };
                            geoCounts.put(country, current + 1);
                        };
                        case null {};
                    };
                };
                case null {};
            };
        };
        
        // Calculate time distribution
        let timeCounts = HashMap.HashMap<Nat, Nat>(0, Nat.equal, Hash.hash);
        for (tx in Buffer.toArray(transactions).vals()) {
            let hour = (tx.timestamp / 3_600_000_000_000) % 24;
            let current = switch (timeCounts.get(hour)) {
                case (?count) { count };
                case null { 0 };
            };
            timeCounts.put(hour, current + 1);
        };
        
        let report: TransactionReport = {
            period = period;
            startTime = startTime;
            endTime = endTime;
            totalTransactions = totalTransactions;
            totalVolume = totalVolume;
            averageTransactionAmount = averageAmount;
            transactionCategories = Iter.toArray(categoryCounts.entries());
            topRecipients = Iter.toArray(recipientCounts.entries());
            riskMetrics = riskMetrics;
            geographicDistribution = Iter.toArray(geoCounts.entries());
            timeDistribution = Iter.toArray(timeCounts.entries());
        };
        
        #ok(report)
    };
    
    // Enhanced transaction management functions
    public shared(msg) func createRecurringPayment(
        to: Principal,
        amount: Amount,
        frequency: PaymentFrequency,
        startDate: Timestamp,
        endDate: ?Timestamp,
        description: ?Text,
        category: ?Text,
        tags: [Text],
        metadata: ?Blob
    ) : async Result.Result<Nat, Text> {
        let caller = msg.caller;
        
        if (startDate <= Time.now()) {
            return #err("Start date must be in the future");
        };
        
        let recurringPayment: RecurringPayment = {
            id = nextRecurringPaymentId;
            from = caller;
            to = to;
            amount = amount;
            frequency = frequency;
            startDate = startDate;
            endDate = endDate;
            lastProcessed = null;
            status = #Active;
            description = description;
            category = category;
            tags = tags;
            metadata = metadata;
        };
        
        recurringPayments.put(nextRecurringPaymentId, recurringPayment);
        nextRecurringPaymentId += 1;
        
        #ok(recurringPayment.id)
    };
    
    public shared(msg) func createBulkTransaction(
        transactions: [BulkTransactionItem],
        description: ?Text,
        category: ?Text,
        tags: [Text],
        metadata: ?Blob
    ) : async Result.Result<Nat, Text> {
        let caller = msg.caller;
        
        if (Array.size(transactions) == 0) {
            return #err("No transactions provided");
        };
        
        let bulkTransaction: BulkTransaction = {
            id = nextBulkTransactionId;
            from = caller;
            transactions = transactions;
            status = #Pending;
            createdAt = Time.now();
            processedAt = null;
            description = description;
            category = category;
            tags = tags;
            metadata = metadata;
        };
        
        bulkTransactions.put(nextBulkTransactionId, bulkTransaction);
        nextBulkTransactionId += 1;
        
        // Process bulk transaction
        await processBulkTransaction(bulkTransaction.id);
        
        #ok(bulkTransaction.id)
    };
    
    // Enhanced error handling functions
    private func attemptErrorRecovery(errorId: Nat) : async Result.Result<(), Text> {
        switch (errorRecoveries.get(errorId)) {
            case (?recovery) {
                if (recovery.attemptCount >= 3) {
                    return #err("Maximum recovery attempts reached");
                };
                
                let updatedRecovery = {
                    id = recovery.id;
                    errorId = recovery.errorId;
                    attemptCount = recovery.attemptCount + 1;
                    lastAttempt = Time.now();
                    status = #InProgress;
                    action = recovery.action;
                    result = null;
                };
                
                errorRecoveries.put(errorId, updatedRecovery);
                
                // Attempt recovery based on action
                switch (recovery.action) {
                    case (#RetryTransaction) {
                        // TODO: Implement transaction retry logic
                        #ok()
                    };
                    case (#RollbackTransaction) {
                        // TODO: Implement transaction rollback logic
                        #ok()
                    };
                    case (#NotifyUser) {
                        // TODO: Implement user notification logic
                        #ok()
                    };
                    case (#EscalateToAdmin) {
                        // TODO: Implement admin escalation logic
                        #ok()
                    };
                    case (#BlockUser) {
                        // TODO: Implement user blocking logic
                        #ok()
                    };
                }
            };
            case null {
                #err("Recovery not found")
            };
        }
    };
    
    // Helper functions
    private func processBulkTransaction(id: Nat) : async () {
        switch (bulkTransactions.get(id)) {
            case (?bulkTx) {
                let updatedTx = {
                    id = bulkTx.id;
                    from = bulkTx.from;
                    transactions = bulkTx.transactions;
                    status = #Processing;
                    createdAt = bulkTx.createdAt;
                    processedAt = ?Time.now();
                    description = bulkTx.description;
                    category = bulkTx.category;
                    tags = bulkTx.tags;
                    metadata = bulkTx.metadata;
                };
                
                bulkTransactions.put(id, updatedTx);
                
                // Process each transaction
                for (item in bulkTx.transactions.vals()) {
                    switch (await processPayment(
                        item.to,
                        item.amount,
                        item.description,
                        item.category,
                        item.tags,
                        item.metadata
                    )) {
                        case (#ok(_)) {};
                        case (#err(e)) {
                            // Handle failed transaction
                            await handleError(
                                id,
                                e,
                                #Business,
                                null
                            );
                        };
                    };
                };
                
                // Update final status
                let finalTx = {
                    id = updatedTx.id;
                    from = updatedTx.from;
                    transactions = updatedTx.transactions;
                    status = #Completed;
                    createdAt = updatedTx.createdAt;
                    processedAt = updatedTx.processedAt;
                    description = updatedTx.description;
                    category = updatedTx.category;
                    tags = updatedTx.tags;
                    metadata = updatedTx.metadata;
                };
                
                bulkTransactions.put(id, finalTx);
            };
            case null {};
        };
    };
    
    // Enhanced security functions
    private func calculateMLScore(user: Principal, transaction: Transaction) : async MLScore {
        let riskFactors = Buffer.Buffer<RiskFactor>(0);
        
        // Calculate transaction velocity risk
        let velocityRisk = switch (transaction.velocity) {
            case (?v) {
                let velocityScore = Float.fromInt(v.lastHour) / 100.0;
                {
                    name = "Transaction Velocity";
                    score = velocityScore;
                    weight = 0.3;
                    description = "High transaction frequency in recent period";
                }
            };
            case null { null };
        };
        
        // Calculate amount risk
        let amountRisk = {
            name = "Transaction Amount";
            score = Float.fromInt(transaction.amount) / 1_000_000.0;
            weight = 0.2;
            description = "Transaction amount relative to typical amounts";
        };
        
        // Calculate geographic risk
        let geoRisk = switch (transaction.geographicData) {
            case (?geo) {
                switch (geo.country) {
                    case (?country) {
                        let countryRisk = await getCountryRiskScore(country);
                        {
                            name = "Geographic Risk";
                            score = countryRisk;
                            weight = 0.2;
                            description = "Risk associated with transaction location";
                        }
                    };
                    case null { null };
                }
            };
            case null { null };
        };
        
        // Calculate user behavior risk
        let behaviorRisk = switch (userBalances.get(user)) {
            case (?balance) {
                let behaviorScore = Float.fromInt(balance.riskScore) / 100.0;
                {
                    name = "User Behavior";
                    score = behaviorScore;
                    weight = 0.3;
                    description = "Risk based on user's transaction history";
                }
            };
            case null { null };
        };
        
        // Combine risk factors
        if (Option.isSome(velocityRisk)) {
            Buffer.add(riskFactors, Option.unwrap(velocityRisk));
        };
        Buffer.add(riskFactors, amountRisk);
        if (Option.isSome(geoRisk)) {
            Buffer.add(riskFactors, Option.unwrap(geoRisk));
        };
        if (Option.isSome(behaviorRisk)) {
            Buffer.add(riskFactors, Option.unwrap(behaviorRisk));
        };
        
        // Calculate final score
        let totalScore = Array.foldLeft<RiskFactor, Float>(
            Buffer.toArray(riskFactors),
            0.0,
            func(acc, factor) { acc + (factor.score * factor.weight) }
        );
        
        {
            fraudProbability = totalScore;
            riskFactors = Buffer.toArray(riskFactors);
            confidence = calculateMLConfidence(riskFactors);
            lastUpdated = Time.now();
        }
    };
    
    private func calculateMLConfidence(riskFactors: [RiskFactor]) : Float {
        let totalWeight = Array.foldLeft<RiskFactor, Float>(
            riskFactors,
            0.0,
            func(acc, factor) { acc + factor.weight }
        );
        
        let weightedVariance = Array.foldLeft<RiskFactor, Float>(
            riskFactors,
            0.0,
            func(acc, factor) {
                let mean = Array.foldLeft<RiskFactor, Float>(
                    riskFactors,
                    0.0,
                    func(sum, f) { sum + f.score }
                ) / Float.fromInt(Array.size(riskFactors));
                
                acc + (factor.weight * (factor.score - mean) * (factor.score - mean))
            }
        );
        
        let standardDeviation = Float.sqrt(weightedVariance / totalWeight);
        1.0 - standardDeviation
    };
    
    private func updateIPReputation(ip: Text, activity: IPActivity) : async () {
        let reputation = switch (ipReputations.get(ip)) {
            case (?r) { r };
            case null {
                {
                    ipAddress = ip;
                    reputationScore = 0.0;
                    riskLevel = #Low;
                    lastActivity = Time.now();
                    activityHistory = [];
                    threatIndicators = [];
                }
            };
        };
        
        // Update activity history
        let updatedHistory = Array.append(reputation.activityHistory, [activity]);
        
        // Calculate new reputation score
        let newScore = calculateReputationScore(updatedHistory);
        
        // Update risk level
        let newRiskLevel = calculateRiskLevel(newScore);
        
        // Update reputation
        let updatedReputation = {
            ipAddress = reputation.ipAddress;
            reputationScore = newScore;
            riskLevel = newRiskLevel;
            lastActivity = Time.now();
            activityHistory = updatedHistory;
            threatIndicators = reputation.threatIndicators;
        };
        
        ipReputations.put(ip, updatedReputation);
    };
    
    // Enhanced analytics functions
    private func updatePredictiveAnalytics() : async () {
        let currentTime = Time.now();
        
        // Generate transaction forecast
        let forecast = await generateTransactionForecast();
        
        // Generate risk predictions
        let riskPredictions = await generateRiskPredictions();
        
        // Analyze user behavior patterns
        let behaviorPatterns = await analyzeBehaviorPatterns();
        
        // Analyze market trends
        let marketTrends = await analyzeMarketTrends();
        
        let analytics: PredictiveAnalytics = {
            transactionForecast = forecast;
            riskPredictions = riskPredictions;
            userBehaviorPatterns = behaviorPatterns;
            marketTrends = marketTrends;
        };
        
        if (Buffer.size(predictiveAnalytics) >= 30) {
            Buffer.removeLast(predictiveAnalytics);
        };
        Buffer.add(predictiveAnalytics, analytics);
    };
    
    private func generateTransactionForecast() : async [TransactionForecast] {
        let forecast = Buffer.Buffer<TransactionForecast>(24);
        
        // Generate hourly forecasts for next 24 hours
        for (hour in Iter.range(0, 23)) {
            let timestamp = Time.now() + Int.abs(hour * 3_600_000_000_000);
            
            // Calculate expected volume based on historical data
            let expectedVolume = await calculateExpectedVolume(hour);
            
            // Calculate confidence based on historical accuracy
            let confidence = await calculateForecastConfidence(hour);
            
            // Identify contributing factors
            let factors = await identifyForecastFactors(hour);
            
            let hourlyForecast: TransactionForecast = {
                timestamp = timestamp;
                expectedVolume = expectedVolume;
                confidence = confidence;
                factors = factors;
            };
            
            Buffer.add(forecast, hourlyForecast);
        };
        
        Buffer.toArray(forecast)
    };
    
    // Implement volume prediction based on historical data
    private func calculateExpectedVolume(hour: Nat) : async Amount {
        let historicalData = Buffer.Buffer<Amount>(30);
        
        // Collect historical data for the same hour over the last 30 days
        for (i in Iter.range(0, Buffer.size(analyticsData) - 1)) {
            let data = Buffer.get(analyticsData, i);
            for ((timestamp, amount) in data.dailyVolume.vals()) {
                let dataHour = (timestamp / 3_600_000_000_000) % 24;
                if (dataHour == hour) {
                    Buffer.add(historicalData, amount);
                };
            };
        };
        
        if (Buffer.size(historicalData) == 0) {
            return 0;
        };
        
        // Calculate weighted average with more recent data having higher weight
        let totalWeight = Float.fromInt(Buffer.size(historicalData) * (Buffer.size(historicalData) + 1)) / 2.0;
        let weightedSum = Array.foldLeft<Amount, Float>(
            Buffer.toArray(historicalData),
            0.0,
            func(acc, amount) {
                let weight = Float.fromInt(Array.size(historicalData) - Array.size(historicalData) + 1);
                acc + (Float.fromInt(amount) * weight)
            }
        );
        
        Int.abs(Float.toInt(weightedSum / totalWeight))
    };
    
    // Implement confidence calculation based on historical accuracy
    private func calculateForecastConfidence(hour: Nat) : async Float {
        let historicalForecasts = Buffer.Buffer<TransactionForecast>(30);
        
        // Collect historical forecasts for the same hour
        for (i in Iter.range(0, Buffer.size(predictiveAnalytics) - 1)) {
            let analytics = Buffer.get(predictiveAnalytics, i);
            for (forecast in analytics.transactionForecast.vals()) {
                let forecastHour = (forecast.timestamp / 3_600_000_000_000) % 24;
                if (forecastHour == hour) {
                    Buffer.add(historicalForecasts, forecast);
                };
            };
        };
        
        if (Buffer.size(historicalForecasts) == 0) {
            return 0.5; // Default confidence for new predictions
        };
        
        // Calculate accuracy based on historical predictions
        let accuracy = Array.foldLeft<TransactionForecast, Float>(
            Buffer.toArray(historicalForecasts),
            0.0,
            func(acc, forecast) {
                acc + forecast.confidence
            }
        ) / Float.fromInt(Buffer.size(historicalForecasts));
        
        // Adjust confidence based on number of historical predictions
        let sampleSizeFactor = Float.min(
            Float.fromInt(Buffer.size(historicalForecasts)) / 30.0,
            1.0
        );
        
        accuracy * sampleSizeFactor
    };
    
    // Implement factor identification for forecasts
    private func identifyForecastFactors(hour: Nat) : async [ForecastFactor] {
        let factors = Buffer.Buffer<ForecastFactor>(0);
        
        // Time-based factors
        let timeFactor = {
            name = "Time of Day";
            impact = if (hour >= 9 and hour <= 17) { 1.2 } else { 0.8 };
            trend = if (hour >= 9 and hour <= 17) { #Up } else { #Down };
        };
        Buffer.add(factors, timeFactor);
        
        // Historical volume factor
        let historicalVolume = await calculateExpectedVolume(hour);
        let volumeFactor = {
            name = "Historical Volume";
            impact = Float.fromInt(historicalVolume) / 1_000_000.0;
            trend = if (historicalVolume > 500_000) { #Up } else { #Down };
        };
        Buffer.add(factors, volumeFactor);
        
        // Risk level factor
        let riskFactor = {
            name = "System Risk Level";
            impact = systemStats.errorStats.errorRate;
            trend = if (systemStats.errorStats.errorRate > 0.1) { #Down } else { #Up };
        };
        Buffer.add(factors, riskFactor);
        
        // User activity factor
        let userActivityFactor = {
            name = "User Activity";
            impact = Float.fromInt(systemStats.activeUsers) / 1000.0;
            trend = if (systemStats.activeUsers > 500) { #Up } else { #Stable };
        };
        Buffer.add(factors, userActivityFactor);
        
        Buffer.toArray(factors)
    };
    
    // Enhanced transaction management functions
    public shared(msg) func createTransactionTemplate(
        name: Text,
        description: Text,
        to: Principal,
        amount: Amount,
        frequency: ?PaymentFrequency,
        category: ?Text,
        tags: [Text],
        metadata: ?Blob,
        schedule: ?Schedule,
        conditions: [TemplateCondition]
    ) : async Result.Result<Nat, Text> {
        let caller = msg.caller;
        
        let template: TransactionTemplate = {
            id = nextTemplateId;
            name = name;
            description = description;
            from = caller;
            to = to;
            amount = amount;
            frequency = frequency;
            category = category;
            tags = tags;
            metadata = metadata;
            schedule = schedule;
            conditions = conditions;
            status = #Active;
        };
        
        transactionTemplates.put(nextTemplateId, template);
        nextTemplateId += 1;
        
        #ok(template.id)
    };
    
    public shared(msg) func executeTemplate(templateId: Nat) : async Result.Result<TransactionId, Text> {
        let caller = msg.caller;
        
        switch (transactionTemplates.get(templateId)) {
            case (?template) {
                if (not Principal.equal(caller, template.from)) {
                    return #err("Only the template owner can execute it");
                };
                
                if (template.status != #Active) {
                    return #err("Template is not active");
                };
                
                // Check conditions
                for (condition in template.conditions.vals()) {
                    if (not await checkTemplateCondition(condition)) {
                        return #err("Template conditions not met");
                    };
                };
                
                // Process payment
                await processPayment(
                    template.to,
                    template.amount,
                    ?template.description,
                    template.category,
                    template.tags,
                    template.metadata
                )
            };
            case null {
                #err("Template not found")
            };
        }
    };
    
    // Implement template condition checking
    private func checkTemplateCondition(condition: TemplateCondition) : async Bool {
        switch (condition.type) {
            case (#Balance) {
                let requiredBalance = Int.abs(Text.toInt(condition.value));
                switch (userBalances.get(msg.caller)) {
                    case (?balance) {
                        switch (condition.operator) {
                            case (#Equals) { balance.balance == requiredBalance };
                            case (#NotEquals) { balance.balance != requiredBalance };
                            case (#GreaterThan) { balance.balance > requiredBalance };
                            case (#LessThan) { balance.balance < requiredBalance };
                            case (#Contains) { false }; // Not applicable for balance
                        }
                    };
                    case null { false };
                }
            };
            case (#Time) {
                let currentHour = (Time.now() / 3_600_000_000_000) % 24;
                let requiredHour = Int.abs(Text.toInt(condition.value));
                switch (condition.operator) {
                    case (#Equals) { currentHour == requiredHour };
                    case (#NotEquals) { currentHour != requiredHour };
                    case (#GreaterThan) { currentHour > requiredHour };
                    case (#LessThan) { currentHour < requiredHour };
                    case (#Contains) { false }; // Not applicable for time
                }
            };
            case (#RiskScore) {
                let requiredScore = Int.abs(Text.toInt(condition.value));
                switch (userBalances.get(msg.caller)) {
                    case (?balance) {
                        switch (condition.operator) {
                            case (#Equals) { balance.riskScore == requiredScore };
                            case (#NotEquals) { balance.riskScore != requiredScore };
                            case (#GreaterThan) { balance.riskScore > requiredScore };
                            case (#LessThan) { balance.riskScore < requiredScore };
                            case (#Contains) { false }; // Not applicable for risk score
                        }
                    };
                    case null { false };
                }
            };
            case (#KYCStatus) {
                switch (userBalances.get(msg.caller)) {
                    case (?balance) {
                        let statusMatches = switch (condition.value) {
                            case ("NotVerified") { balance.kycStatus == #NotVerified };
                            case ("Pending") { balance.kycStatus == #Pending };
                            case ("Verified") { balance.kycStatus == #Verified };
                            case ("Rejected") { balance.kycStatus == #Rejected };
                            case (_) { false };
                        };
                        switch (condition.operator) {
                            case (#Equals) { statusMatches };
                            case (#NotEquals) { not statusMatches };
                            case (#GreaterThan) { false }; // Not applicable for KYC status
                            case (#LessThan) { false }; // Not applicable for KYC status
                            case (#Contains) { false }; // Not applicable for KYC status
                        }
                    };
                    case null { false };
                }
            };
            case (#Custom) {
                // Custom conditions can be implemented based on specific requirements
                // For now, we'll return true to allow custom conditions
                true
            };
        }
    };
    
    // Enhanced error handling functions
    private func resolveError(errorId: Nat) : async Result.Result<(), Text> {
        let resolution: ErrorResolution = {
            id = nextResolutionId;
            errorId = errorId;
            resolutionType = #Automatic;
            status = #Pending;
            attempts = [];
            finalResult = null;
            resolvedAt = null;
        };
        
        errorResolutions.put(nextResolutionId, resolution);
        nextResolutionId += 1;
        
        // Attempt automatic resolution
        let attempt: ResolutionAttempt = {
            timestamp = Time.now();
            type = #Automatic;
            result = "Initial attempt";
            success = false;
            details = null;
        };
        
        let updatedResolution = {
            id = resolution.id;
            errorId = resolution.errorId;
            resolutionType = resolution.resolutionType;
            status = #InProgress;
            attempts = [attempt];
            finalResult = null;
            resolvedAt = null;
        };
        
        errorResolutions.put(resolution.id, updatedResolution);
        
        // Try to resolve the error
        switch (await attemptAutomaticResolution(errorId)) {
            case (#ok()) {
                let finalResolution = {
                    id = updatedResolution.id;
                    errorId = updatedResolution.errorId;
                    resolutionType = updatedResolution.resolutionType;
                    status = #Resolved;
                    attempts = updatedResolution.attempts;
                    finalResult = ?"Successfully resolved";
                    resolvedAt = ?Time.now();
                };
                
                errorResolutions.put(resolution.id, finalResolution);
                #ok()
            };
            case (#err(e)) {
                // Escalate to manual resolution
                let escalatedResolution = {
                    id = updatedResolution.id;
                    errorId = updatedResolution.errorId;
                    resolutionType = #Hybrid;
                    status = #Escalated;
                    attempts = updatedResolution.attempts;
                    finalResult = ?"Escalated for manual review";
                    resolvedAt = null;
                };
                
                errorResolutions.put(resolution.id, escalatedResolution);
                #err("Error requires manual intervention")
            };
        }
    };
    
    // Implement automatic error resolution logic
    private func attemptAutomaticResolution(errorId: Nat) : async Result.Result<(), Text> {
        switch (errorRecoveries.get(errorId)) {
            case (?recovery) {
                switch (recovery.action) {
                    case (#RetryTransaction) {
                        // Get the failed transaction
                        let failedTx = switch (transactions.get(recovery.errorId)) {
                            case (?tx) { tx };
                            case null { return #err("Transaction not found") };
                        };
                        
                        // Attempt to process the payment again
                        switch (await processPayment(
                            failedTx.to,
                            failedTx.amount,
                            failedTx.description,
                            failedTx.category,
                            failedTx.tags,
                            failedTx.metadata
                        )) {
                            case (#ok(_)) { #ok() };
                            case (#err(e)) { #err(e) };
                        }
                    };
                    case (#RollbackTransaction) {
                        // Get the failed transaction
                        let failedTx = switch (transactions.get(recovery.errorId)) {
                            case (?tx) { tx };
                            case null { return #err("Transaction not found") };
                        };
                        
                        // Attempt to reverse the transaction
                        switch (await updateBalances(failedTx.to, failedTx.from, failedTx.amount)) {
                            case (#ok()) { #ok() };
                            case (#err(e)) { #err(e) };
                        }
                    };
                    case (#NotifyUser) {
                        // In a real implementation, this would send a notification to the user
                        // For now, we'll just mark it as successful
                        #ok()
                    };
                    case (#EscalateToAdmin) {
                        // In a real implementation, this would notify administrators
                        // For now, we'll just mark it as successful
                        #ok()
                    };
                    case (#BlockUser) {
                        // Get the failed transaction
                        let failedTx = switch (transactions.get(recovery.errorId)) {
                            case (?tx) { tx };
                            case null { return #err("Transaction not found") };
                        };
                        
                        // Block the user
                        let updatedBalance = switch (userBalances.get(failedTx.from)) {
                            case (?balance) {
                                {
                                    principal = balance.principal;
                                    balance = balance.balance;
                                    transactions = balance.transactions;
                                    lastTransactionTimestamp = balance.lastTransactionTimestamp;
                                    totalTransactions = balance.totalTransactions;
                                    riskScore = balance.riskScore;
                                    isBlocked = true;
                                    blockReason = ?"Automatic blocking due to error";
                                    blockExpiry = ?(Time.now() + BLOCK_DURATION);
                                    kycStatus = balance.kycStatus;
                                    lastKycUpdate = balance.lastKycUpdate;
                                    rateLimit = balance.rateLimit;
                                    behavior = balance.behavior;
                                    geographicData = balance.geographicData;
                                    transactionLimits = balance.transactionLimits;
                                }
                            };
                            case null { return #err("User not found") };
                        };
                        
                        userBalances.put(failedTx.from, updatedBalance);
                        #ok()
                    };
                }
            };
            case null {
                #err("Recovery not found")
            };
        }
    };
    // Implement error code mapping
    private func mapErrorCode(error: Text, category: ErrorCategory) : Nat {
        let baseCode = switch (category) {
            case (#Validation) { 1000 };
            case (#Security) { 2000 };
            case (#Network) { 3000 };
            case (#System) { 4000 };
            case (#Business) { 5000 };
            case (#Unknown) { 9000 };
        };
        
        // Add specific error codes based on error message
        let specificCode = switch (error) {
            case ("Amount must be greater than 0") { 1 };
            case ("Cannot send payment to yourself") { 2 };
            case ("Transaction flagged as potentially fraudulent") { 3 };
            case ("Transaction velocity exceeds daily limit") { 4 };
            case ("Transaction amount exceeds per-transaction limit") { 5 };
            case ("Suspicious IP address detected") { 6 };
            case ("Unusual transaction pattern detected") { 7 };
            case ("Insufficient number of signers") { 8 };
            case ("Transaction is not pending") { 9 };
            case ("Transaction already has sufficient signatures") { 10 };
            case ("Already signed by this user") { 11 };
            case ("Scheduled time must be in the future") { 12 };
            case ("Only the sender can request a refund") { 13 };
            case ("Only completed transactions can be refunded") { 14 };
            case ("Invalid refund request") { 15 };
            case ("Only the sender can cancel the transaction") { 16 };
            case ("Only pending transactions can be cancelled") { 17 };
            case ("Unauthorized") { 18 };
            case ("User not found") { 19 };
            case ("Transaction not found") { 20 };
            case ("Rate limit exceeded") { 21 };
            case ("Template conditions not met") { 22 };
            case ("Template is not active") { 23 };
            case (_) { 0 };
        };
        
        baseCode + specificCode
    };
    // Implement response time tracking
    private func trackResponseTime(startTime: Int) : async () {
        let endTime = Time.now();
        let responseTime = endTime - startTime;
        
        systemStats := {
            totalTransactions = systemStats.totalTransactions;
            totalUsers = systemStats.totalUsers;
            totalNFTReceipts = systemStats.totalNFTReceipts;
            totalVolume = systemStats.totalVolume;
            lastUpdate = Time.now();
            activeUsers = systemStats.activeUsers;
            blockedUsers = systemStats.blockedUsers;
            pendingKyc = systemStats.pendingKyc;
            rejectedKyc = systemStats.rejectedKyc;
            totalRefunds = systemStats.totalRefunds;
            totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
            systemHealth = {
                lastCheck = systemStats.systemHealth.lastCheck;
                errorRate = systemStats.systemHealth.errorRate;
                averageResponseTime = (systemStats.systemHealth.averageResponseTime + responseTime) / 2;
                activeConnections = systemStats.systemHealth.activeConnections;
                systemLoad = systemStats.systemHealth.systemLoad;
                memoryUsage = systemStats.systemHealth.memoryUsage;
            };
            errorStats = systemStats.errorStats;
            velocityStats = systemStats.velocityStats;
        };
    };
    // Implement connection tracking
    private func trackConnection(connected: Bool) : async () {
        let currentConnections = if (connected) {
            systemStats.systemHealth.activeConnections + 1
        } else {
            if (systemStats.systemHealth.activeConnections > 0) {
                systemStats.systemHealth.activeConnections - 1
            } else {
                0
            }
        };
        
        systemStats := {
            totalTransactions = systemStats.totalTransactions;
            totalUsers = systemStats.totalUsers;
            totalNFTReceipts = systemStats.totalNFTReceipts;
            totalVolume = systemStats.totalVolume;
            lastUpdate = Time.now();
            activeUsers = systemStats.activeUsers;
            blockedUsers = systemStats.blockedUsers;
            pendingKyc = systemStats.pendingKyc;
            rejectedKyc = systemStats.rejectedKyc;
            totalRefunds = systemStats.totalRefunds;
            totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
            systemHealth = {
                lastCheck = systemStats.systemHealth.lastCheck;
                errorRate = systemStats.systemHealth.errorRate;
                averageResponseTime = systemStats.systemHealth.averageResponseTime;
                activeConnections = currentConnections;
                systemLoad = systemStats.systemHealth.systemLoad;
                memoryUsage = systemStats.systemHealth.memoryUsage;
            };
            errorStats = systemStats.errorStats;
            velocityStats = systemStats.velocityStats;
        };
    };
    // Implement system load tracking
    private func trackSystemLoad() : async () {
        let currentLoad = Float.fromInt(systemStats.activeUsers) / 1000.0;
        
        systemStats := {
            totalTransactions = systemStats.totalTransactions;
            totalUsers = systemStats.totalUsers;
            totalNFTReceipts = systemStats.totalNFTReceipts;
            totalVolume = systemStats.totalVolume;
            lastUpdate = Time.now();
            activeUsers = systemStats.activeUsers;
            blockedUsers = systemStats.blockedUsers;
            pendingKyc = systemStats.pendingKyc;
            rejectedKyc = systemStats.rejectedKyc;
            totalRefunds = systemStats.totalRefunds;
            totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
            systemHealth = {
                lastCheck = systemStats.systemHealth.lastCheck;
                errorRate = systemStats.systemHealth.errorRate;
                averageResponseTime = systemStats.systemHealth.averageResponseTime;
                activeConnections = systemStats.systemHealth.activeConnections;
                systemLoad = currentLoad;
                memoryUsage = systemStats.systemHealth.memoryUsage;
            };
            errorStats = systemStats.errorStats;
            velocityStats = systemStats.velocityStats;
        };
    };
    // Implement memory usage tracking
    private func trackMemoryUsage() : async () {
        let currentMemory = Float.fromInt(systemStats.totalTransactions) / 1_000_000.0;
        
        systemStats := {
            totalTransactions = systemStats.totalTransactions;
            totalUsers = systemStats.totalUsers;
            totalNFTReceipts = systemStats.totalNFTReceipts;
            totalVolume = systemStats.totalVolume;
            lastUpdate = Time.now();
            activeUsers = systemStats.activeUsers;
            blockedUsers = systemStats.blockedUsers;
            pendingKyc = systemStats.pendingKyc;
            rejectedKyc = systemStats.rejectedKyc;
            totalRefunds = systemStats.totalRefunds;
            totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
            systemHealth = {
                lastCheck = systemStats.systemHealth.lastCheck;
                errorRate = systemStats.systemHealth.errorRate;
                averageResponseTime = systemStats.systemHealth.averageResponseTime;
                activeConnections = systemStats.systemHealth.activeConnections;
                systemLoad = systemStats.systemHealth.systemLoad;
                memoryUsage = currentMemory;
            };
            errorStats = systemStats.errorStats;
            velocityStats = systemStats.velocityStats;
        };
    };
    // Update handleError function to use error code mapping
    private func handleError(
        transactionId: TransactionId,
        error: Text,
        category: ErrorCategory,
        stackTrace: ?Text
    ) : async () {
        let errorDetails: ErrorDetails = {
            code = mapErrorCode(error, category);
            category = category;
            timestamp = Time.now();
            stackTrace = stackTrace;
            recoveryAttempted = false;
            recoveryStatus = null;
        };
        
        switch (transactions.get(transactionId)) {
            case (?transaction) {
                let updatedTransaction = {
                    id = transaction.id;
                    from = transaction.from;
                    to = transaction.to;
                    amount = transaction.amount;
                    timestamp = transaction.timestamp;
                    status = #Failed;
                    nftReceiptId = transaction.nftReceiptId;
                    errorMessage = ?error;
                    description = transaction.description;
                    category = transaction.category;
                    tags = transaction.tags;
                    metadata = transaction.metadata;
                    refundStatus = transaction.refundStatus;
                    velocity = transaction.velocity;
                    geographicData = transaction.geographicData;
                    signatures = transaction.signatures;
                    scheduledFor = transaction.scheduledFor;
                    templateId = transaction.templateId;
                    errorDetails = ?errorDetails;
                };
                
                transactions.put(transactionId, updatedTransaction);
                
                // Update system error stats
                systemStats := {
                    totalTransactions = systemStats.totalTransactions;
                    totalUsers = systemStats.totalUsers;
                    totalNFTReceipts = systemStats.totalNFTReceipts;
                    totalVolume = systemStats.totalVolume;
                    lastUpdate = Time.now();
                    activeUsers = systemStats.activeUsers;
                    blockedUsers = systemStats.blockedUsers;
                    pendingKyc = systemStats.pendingKyc;
                    rejectedKyc = systemStats.rejectedKyc;
                    totalRefunds = systemStats.totalRefunds;
                    totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
                    systemHealth = systemStats.systemHealth;
                    errorStats = {
                        totalErrors = systemStats.errorStats.totalErrors + 1;
                        errorByCategory = Array.append(
                            systemStats.errorStats.errorByCategory,
                            [(category, 1)]
                        );
                        recentErrors = Array.append(
                            systemStats.errorStats.recentErrors,
                            [errorDetails]
                        );
                        errorRate = Float.fromInt(systemStats.errorStats.totalErrors + 1) / Float.fromInt(systemStats.totalTransactions);
                    };
                    velocityStats = systemStats.velocityStats;
                };
            };
            case null {};
        };
    };
    // Update updateSystemHealth function to use new tracking functions
    private func updateSystemHealth() : async () {
        let currentTime = Time.now();
        let health = systemStats.systemHealth;
        
        // Update all system health metrics
        await trackResponseTime(health.lastCheck);
        await trackSystemLoad();
        await trackMemoryUsage();
        
        // Update system health record
        systemStats := {
            totalTransactions = systemStats.totalTransactions;
            totalUsers = systemStats.totalUsers;
            totalNFTReceipts = systemStats.totalNFTReceipts;
            totalVolume = systemStats.totalVolume;
            lastUpdate = currentTime;
            activeUsers = systemStats.activeUsers;
            blockedUsers = systemStats.blockedUsers;
            pendingKyc = systemStats.pendingKyc;
            rejectedKyc = systemStats.rejectedKyc;
            totalRefunds = systemStats.totalRefunds;
            totalFraudulentTransactions = systemStats.totalFraudulentTransactions;
            systemHealth = {
                lastCheck = currentTime;
                errorRate = systemStats.errorStats.errorRate;
                averageResponseTime = systemStats.systemHealth.averageResponseTime;
                activeConnections = systemStats.systemHealth.activeConnections;
                systemLoad = systemStats.systemHealth.systemLoad;
                memoryUsage = systemStats.systemHealth.memoryUsage;
            };
            errorStats = systemStats.errorStats;
            velocityStats = systemStats.velocityStats;
        };
    };
}