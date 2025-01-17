/**
 *Submitted for verification at snowtrace.io on 2021-12-15
*/

// File contracts/interfaces/IHauntedHouse.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface IHauntedHouse {
    struct TokenInfo {
        address rewarder; // Address of rewarder for token
        address strategy; // Address of strategy for token
        uint256 lastRewardTime; // Last time that BOOFI distribution occurred for this token
        uint256 lastCumulativeReward; // Value of cumulativeAvgZboofiPerWeightedDollar at last update
        uint256 storedPrice; // Latest value of token
        uint256 accZBOOFIPerShare; // Accumulated BOOFI per share, times ACC_BOOFI_PRECISION.
        uint256 totalShares; //total number of shares for the token
        uint256 totalTokens; //total number of tokens deposited
        uint128 multiplier; // multiplier for this token
        uint16 withdrawFeeBP; // Withdrawal fee in basis points
    }
    function BOOFI() external view returns (address);
    function strategyPool() external view returns (address);
    function performanceFeeAddress() external view returns (address);
    function updatePrice(address token, uint256 newPrice) external;
    function updatePrices(address[] calldata tokens, uint256[] calldata newPrices) external;
    function tokenList() external view returns (address[] memory);
    function tokenParameters(address tokenAddress) external view returns (TokenInfo memory);
    function deposit(address token, uint256 amount, address to) external;
    function harvest(address token, address to) external;
    function withdraw(address token, uint256 amountShares, address to) external;
}


// File contracts/interfaces/IUniswapV2TWAP.sol

pragma solidity >=0.5.0;

interface IUniswapV2TWAP {
    function consult(address tokenA, address tokenB, address tokenIn, uint256 amountIn) external view returns (uint256 amountOut);
    function consultWithUpdate(address tokenA, address tokenB, address tokenIn, uint256 amountIn) external returns (uint256 amountOut);
}


// File @uniswap/v2-core/contracts/interfaces/[email protected]

pragma solidity >=0.5.0;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


// File @openzeppelin/contracts/utils/[email protected]


pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File @openzeppelin/contracts/access/[email protected]


pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


// File contracts/CauldronPriceUpdater.sol

//based on: https://github.com/Uniswap/uniswap-v2-periphery/tree/master/contracts/examples
pragma solidity ^0.8.6;




contract CauldronPriceUpdater is Ownable {
    address constant WAVAX = 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7;
    //whitelist of addresses that can call this contract
    mapping(address => bool) whitelist;
    //tracks is a token is an LP or not
    mapping(address => bool) lpTokens;
    //address of oracle to consult
    address public oracle;
    //address of HauntedHouse
    address public immutable hauntedHouse;
    event OracleSet();
    modifier onlyWhitelist() {
        require(whitelist[msg.sender], "only callable by whitelisted addresses");
        _;
    }
    constructor(address _hauntedHouse, address _oracle) {
        hauntedHouse = _hauntedHouse;
        setOracle(_oracle);
        whitelist[msg.sender] = true;
    }
    //VIEW FUNCTIONS
    function getTokenPriceView(address token) public view returns (uint256) {
        //NOTE: return value is SCALED UP by 1e18, as this is the input amount in consulting the oracle
        if (token != WAVAX) {
            return IUniswapV2TWAP(oracle).consult(token, WAVAX, token, 1e18);
        } else {
            return 1e18;
        }
    }
    function getPriceOfLPView(address lpToken) public view returns (uint256) {
        address token0 = IUniswapV2Pair(lpToken).token0();
        address token1 = IUniswapV2Pair(lpToken).token1();
        uint256 priceToken0 = getTokenPriceView(token0);
        uint256 priceToken1 = getTokenPriceView(token1);
        (uint256 balanceToken0, uint256 balanceToken1, ) = IUniswapV2Pair(lpToken).getReserves();
        uint256 lpTVL = (priceToken0 * balanceToken0) + (priceToken1 * balanceToken1);
        return lpTVL / IUniswapV2Pair(lpToken).totalSupply();
    }
    //PUBLIC WRITE FUNCTIONS
    function getTokenPrice(address token) public returns (uint256) {
        //NOTE: return value is SCALED UP by 1e18, as this is the input amount in consulting the oracle
        if (token != WAVAX) {
            return IUniswapV2TWAP(oracle).consultWithUpdate(token, WAVAX, token, 1e18);
        } else {
            return 1e18;
        }
    }
    function getPriceOfLP(address lpToken) public returns (uint256) {
        address token0 = IUniswapV2Pair(lpToken).token0();
        address token1 = IUniswapV2Pair(lpToken).token1();
        uint256 priceToken0 = getTokenPrice(token0);
        uint256 priceToken1 = getTokenPrice(token1);
        (uint256 balanceToken0, uint256 balanceToken1, ) = IUniswapV2Pair(lpToken).getReserves();
        uint256 lpTVL = (priceToken0 * balanceToken0) + (priceToken1 * balanceToken1);
        return lpTVL / IUniswapV2Pair(lpToken).totalSupply();
    }
    //OWNER-ONLY FUNCTIONS
    function setOracle(address _oracle) public onlyOwner {
        oracle = _oracle;
    }
    function modifyWhitelist(address[] calldata addresses, bool[] calldata statuses) external onlyOwner {
        require(addresses.length == statuses.length, "input length mismatch");
        for (uint256 i = 0; i < addresses.length; i++) {
            whitelist[addresses[i]] = statuses[i];
        }
    }
    function addLPTokens(address[] calldata tokens) external onlyOwner {
        for (uint256 i = 0; i < tokens.length; i++) {
            lpTokens[tokens[i]] = true;
        }
    }
    function removeLPTokens(address[] calldata tokens) external onlyOwner {
        for (uint256 i = 0; i < tokens.length; i++) {
            lpTokens[tokens[i]] = false;
        }
    }
    //WHITELIST-ONLY FUNCTIONS
    function setPrice(address token) public onlyWhitelist {
        uint256 tokenPrice;
        if(lpTokens[token]) {
            tokenPrice = getPriceOfLP(token);
        } else {
            tokenPrice = getTokenPrice(token);
        }
        IHauntedHouse(hauntedHouse).updatePrice(token, tokenPrice);
    }
    function setPrices(address[] memory tokens) public onlyWhitelist {
        uint256[] memory tokenPrices = new uint256[](tokens.length);
        for (uint256 i = 0; i < tokens.length; i++) {
            if(lpTokens[tokens[i]]) {
                tokenPrices[i] = getPriceOfLP(tokens[i]);
            } else {
                tokenPrices[i] = getTokenPrice(tokens[i]);
            }
        }
        IHauntedHouse(hauntedHouse).updatePrices(tokens, tokenPrices);
    }
    function setAllPrices() external onlyWhitelist {
        address[] memory tokens = IHauntedHouse(hauntedHouse).tokenList();
        setPrices(tokens);
    }
}