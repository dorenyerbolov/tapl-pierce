/* PROBLEM 1 */

/* Sum types */  
Euro = {euros: Float};
Dollar = {dollars: Float};
Rub = {rubs: Float};
Tenge = {tenges: Float};

/* Currency (variant type) = Euro + Dollar + Rub + Tenge */
Currency = <euro: Euro, dollar: Dollar, rub: Rub, tenge: Tenge>;

/* Enumeration for currency */
CurrencyEnum = <euro: Unit, dollar: Unit, rub: Unit, tenge: Unit>;

/* Tenge converter */
looseMoney2Tenge =     
    lambda amount: Currency.
        case amount of <euro = x> ==> {tenges = timesfloat x.euros 464.39} as Tenge
                     | <dollar = x> ==> {tenges = timesfloat x.dollars 427.20} as Tenge
                     | <rub = x> ==> {tenges = timesfloat x.rubs 5.76} as Tenge;

/* Rub converter */
looseMoney2Rub =     
    lambda amount: Currency.
        case amount of <euro = x> ==> {rubs = timesfloat x.euros 80.61} as Rub
                     | <dollar = x> ==> {rubs = timesfloat x.dollars 74.11} as Rub
                     | <tenge = x> ==> {rubs = timesfloat x.tenges 0.17} as Rub;

/* Dollar converter */
looseMoney2Dollar =     
    lambda amount: Currency.
        case amount of <euro = x> ==> {dollars = timesfloat x.euros 1.09} as Dollar
                     | <tenge = x> ==> {dollars = timesfloat x.tenges 0.0023} as Dollar
                     | <rub = x> ==> {dollars = timesfloat x.rubs 0.013} as Dollar;

/* Euro converter */
looseMoney2Euro =     
    lambda amount: Currency.
        case amount of <tenge = x> ==> {euros = timesfloat x.tenges 0.0022} as Euro
                     | <dollar = x> ==> {euros = timesfloat x.dollars 0.92} as Euro
                     | <rub = x> ==> {euros = timesfloat x.rubs 0.012} as Euro;

/* Converter to a specific currency */
convert = 
    lambda amount: Currency. lambda targetCurrency: CurrencyEnum.
        case targetCurrency of <tenge = x> ==> <tenge = looseMoney2Tenge amount> as Currency
                             | <rub = x> ==> <rub = looseMoney2Rub amount> as Currency
                             | <dollar = x> ==> <dollar = looseMoney2Dollar amount> as Currency
                             | <euro = x> ==> <euro = looseMoney2Euro amount> as Currency;


ea = {euros = 4.0} as Euro;
da = {dollars = 5.0} as Dollar;
ra = {rubs = 6.0} as Rub;

currency1 = <euro = ea> as Currency; 
currency2 = <dollar = da> as Currency;
currency3 = <rub = ra> as Currency;

currency4 = <rub = unit> as CurrencyEnum;

convert currency1 currency4;

looseMoney2Tenge currency1;
looseMoney2Tenge currency2;
looseMoney2Tenge currency3;