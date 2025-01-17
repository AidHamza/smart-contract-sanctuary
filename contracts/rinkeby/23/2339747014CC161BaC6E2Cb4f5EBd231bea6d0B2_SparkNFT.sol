/**
 *Submitted for verification at Etherscan.io on 2021-08-26
*/

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// File contracts/IERC721.sol



pragma solidity >= 0.8.0;

/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
///  Note: the ERC-165 identifier for this interface is 0x80ac58cd.
interface IERC721 is IERC165 {
    /// @dev This emits when ownership of any NFT changes by any mechanism.
    ///  This event emits when NFTs are created (`from` == 0) and destroyed
    ///  (`to` == 0). Exception: during contract creation, any number of NFTs
    ///  may be created and assigned without emitting Transfer. At the time of
    ///  any transfer, the approved address for that NFT (if any) is reset to none.
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    /// @dev This emits when the approved address for an NFT is changed or
    ///  reaffirmed. The zero address indicates there is no approved address.
    ///  When a Transfer event emits, this also indicates that the approved
    ///  address for that NFT (if any) is reset to none.
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    /// @dev This emits when an operator is enabled or disabled for an owner.
    ///  The operator can manage all NFTs of the owner.
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256);

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address);

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
    ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
    ///  `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    /// @param data Additional data with no specified format, sent in call to `_to`
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev This works identically to the other function with an extra data parameter,
    ///  except this function just sets data to "".
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve
    function approve(address _approved, uint256 _tokenId) external payable;

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param _operator Address to add to the set of authorized operators
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) external;

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT.
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view returns (address);

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}


// File contracts/IERC721Metadata.sol



pragma solidity ^0.8.0;

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721Metadata is IERC721 {
    /**
     * @dev Returns the token collection name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);
}


// File @openzeppelin/contracts/token/ERC20/[email protected]



pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// File @openzeppelin/contracts/utils/[email protected]



pragma solidity ^0.8.0;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts/token/ERC20/utils/[email protected]



pragma solidity ^0.8.0;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// File @openzeppelin/contracts/utils/math/[email protected]



pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is no longer needed starting with Solidity 0.8. The compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}


// File @openzeppelin/contracts/utils/[email protected]



pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}


// File @openzeppelin/contracts/utils/[email protected]



pragma solidity ^0.8.0;

/*
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


// File contracts/IERC721Receiver.sol



pragma solidity ^0.8.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}


// File @openzeppelin/contracts/utils/[email protected]



pragma solidity ^0.8.0;

/**
 * @dev String operations.
 */
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}


// File @openzeppelin/contracts/utils/introspection/[email protected]



pragma solidity ^0.8.0;

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}


// File contracts/royaltyNFT.sol



pragma solidity >= 0.8.0;











contract royaltyNFT is Context, ERC165, IERC721, IERC721Metadata{
    using Address for address;
    using SafeERC20 for IERC20;
    using Counters for Counters.Counter;
    using SafeMath for uint256;
    Counters.Counter private _issueIds;
    struct Issue {
        // The publisher publishes a series of NFTs with the same content and different NFT_id each time.
        // This structure is used to store the public attributes of same series of NFTs.
        uint192 issue_id;
        // Number of NFTs have not been minted in this series
        uint8 royalty_fee;
        // Used to identify which series it is.
        address payable publisher;
        // Publisher of this series NFTs
        uint64 total_edition_amount;
        // Number of NFTs included in this series
        uint64 remain_edition_amount;
        // royalty_fee for every transfer expect from or to exclude address, max is 100;
        string ipfs_hash;
        // Metadata json file.
        string name;
        // issue's name
        mapping (address => uint256) base_royaltyfee;
        // List of tokens(address) can be accepted for payment.
        // And specify the min fee should be toke when series of NFTs are sold.
        // If base_royaltyfee[tokens] == 0, then this token will not be accepted.
        // `A token address` can be ERC-20 token contract address or `address(0)`(ETH).
        mapping (address => uint256) first_sell_price;
        // The price should be payed when this series NTFs are minted.
        // 这两个mapping如果存在token_addr看价格是不可以等于0的，如果等于0的话会导致判不支持
        // 由于这个价格是写死的，可能会诱导用户的付款倾向
    }

    struct Edition {
        // Information used to decribe an NFT.
        uint256 NFT_id;
        // Index of this NFT.
        uint256 transfer_price;
        // The price of the NFT in the transaction is determined before the transaction.
        address token_addr;
        // The tokens used in this transcation, determined together with the price.
        bool is_on_sale;
    }
    mapping (uint256 => Issue) private issues_by_id;
    mapping (uint256 => Edition) private editions_by_id;
    // Address which will not be taken fee in secondary transcation.
    event determinePriceSuccess(
        uint256 NFT_id,
        address token_addr,
        uint256 transfer_price
    );
    event determinePriceAndApproveSuccess(
        uint256 NFT_id,
        address token_addr,
        uint256 transfer_price,
        address to
    );
    // ? 在一个event中塞进去多个数组会不会影响gas开销
    event publishSuccess(
	    string name, 
	    uint256 issue_id,
        address publisher,
        uint256 total_edition_amount,
        uint8 royalty_fee,
        address[] token_addrs,
        uint256[] base_royaltyfee,
        uint256[] first_sell_price
    );
    // 三个数组变量需要用其他的办法获取，比如说public函数，不能够放在一个事件里面

    event buySuccess (
        address publisher,
        uint256 NFT_id,
        address transfer_token_addr,
        uint256 transfer_price,
        address buyer
    );
    event transferSuccess(
        uint256 NFT_id,
        address from,
        address to,
        uint256 transfer_price,
        address transfer_token_addr
    );
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;
    //----------------------------------------------------------------------------------------------------
    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor() {
        _name = "royaltyNFT";
        _symbol = "royaltyNFT";

        _issueIds.increment();
    }
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOf(address owner) public view virtual override returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _balances[owner];
    }

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev See {IERC721-approve}.
     */
    function approve(address to, uint256 tokenId) public payable virtual override {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

    /**
     * @dev See {IERC721-getApproved}.
     */
    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev See {IERC721-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC721-isApprovedForAll}.
     */
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function _baseURI() internal pure returns (string memory) {
        return "https://ipfs.io/ipfs/";
    } /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();
        return string(abi.encodePacked(base, _tokenURI));
        
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal {
        address owner = ownerOf(tokenId);
        // Clear approvals
        _approve(address(0), tokenId);

        _balances[owner] -= 1;
        delete _owners[tokenId];

        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }

        emit Transfer(owner, address(0), tokenId);
    }
    /**
     * @dev Determine NFT price before transfer.
     *
     * Requirements:
     * 
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     *
     * Emits a {determinePriceSuccess} event, which contains:
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     */
     // ？ 这个地方有个问题，按照这篇文章https://gus-tavo-guim.medium.com/public-vs-external-functions-in-solidity-b46bcf0ba3ac
     // 在external函数之中使用calldata进行传参数的gas消耗应该会更少一点
     // 但是大部分地方能看到的都是memory
     // 如何检测他传入的erc20地址是一个正常的地址
    function publish(
        address[] memory _token_addrs, 
        uint256[] memory _base_royaltyfee,
        uint256[] memory _first_sell_price,
        uint8 _royalty_fee,
        uint64 _total_edition_amount,
        string memory _issue_name,
        string memory _ipfs_hash
    ) external {
        require(_royalty_fee <= 100, "royaltyNFT: royalty fee should less than 100.");
        require(_token_addrs.length == _base_royaltyfee.length && _base_royaltyfee.length == _first_sell_price.length, 
                "royaltyNFT: token address array length should be equal to others.");
        _issueIds.increment();
        uint192 max_192 = type(uint192).max;
        uint64 max_64 = type(uint64).max;
        require(_total_edition_amount <= max_64, "royaltyNFT: Edition amount doesn't fit in 64 bits");
        require((_issueIds.current()) <= max_192, "royaltyNFT: Issue id doesn't fit in 192 bits");
        uint192 new_issue_id = uint64(_issueIds.current());
        _publish(new_issue_id, _token_addrs, _base_royaltyfee, _first_sell_price, _royalty_fee, _total_edition_amount, _issue_name, _ipfs_hash);
        emit publishSuccess(
            issues_by_id[new_issue_id].name, 
            issues_by_id[new_issue_id].issue_id,
            issues_by_id[new_issue_id].publisher,
            issues_by_id[new_issue_id].total_edition_amount,
            issues_by_id[new_issue_id].royalty_fee,
            _token_addrs,
            _base_royaltyfee,
            _first_sell_price
        );
    }
    function _publish(
        uint192 new_issue_id,
        address[] memory _token_addrs, 
        uint256[] memory _base_royaltyfee,
        uint256[] memory _first_sell_price,
        uint8 _royalty_fee,
        uint64 _total_edition_amount,
        string memory _issue_name,
        string memory _ipfs_hash) internal {
        Issue storage new_issue = issues_by_id[new_issue_id];
        new_issue.name = _issue_name;
        new_issue.issue_id = new_issue_id;
        new_issue.publisher = payable(msg.sender);
        new_issue.royalty_fee = _royalty_fee;
        new_issue.total_edition_amount = _total_edition_amount;
        new_issue.remain_edition_amount = _total_edition_amount;
        // ?此处的ipfshash是代表着pdf还是metadata
        new_issue.ipfs_hash = _ipfs_hash;
        for (uint8 _token_addr_id = 0; _token_addr_id < _token_addrs.length; _token_addr_id++){
            new_issue.base_royaltyfee[_token_addrs[_token_addr_id]] = _base_royaltyfee[_token_addr_id];
            new_issue.first_sell_price[_token_addrs[_token_addr_id]] = _first_sell_price[_token_addr_id];
        }
    }
    function buy(
        uint192 _issue_id, 
        address _token_addr
    ) public payable {
        require(isIssueExist(_issue_id), "royaltyNFT: This issue is not exist.");
        require(issues_by_id[_issue_id].first_sell_price[_token_addr] != 0, "royaltyNFT: The token your selected is not supported.");
        if (_token_addr == address(0)) {
            require(msg.value == issues_by_id[_issue_id].first_sell_price[_token_addr], "royaltyNFT: not enought ETH");
            issues_by_id[_issue_id].publisher.transfer(issues_by_id[_issue_id].first_sell_price[_token_addr]);
        }
        else {
            IERC20(_token_addr).safeTransferFrom(msg.sender, issues_by_id[_issue_id].publisher, issues_by_id[_issue_id].first_sell_price[_token_addr]);
        }
        uint256 NFT_id = _mintNFT(_issue_id);

        emit buySuccess (
            issues_by_id[_issue_id].publisher,
            NFT_id,
            _token_addr,
            issues_by_id[_issue_id].first_sell_price[_token_addr],
            msg.sender
        );

    }



    function _mintNFT(
        uint192 _issue_id
    ) internal returns (uint256) {
        require((issues_by_id[_issue_id].remain_edition_amount > 0), "royaltyNFT: There is no NFT remain in this issue.");
        uint128 new_editions_id = uint128(issues_by_id[_issue_id].total_edition_amount - issues_by_id[_issue_id].remain_edition_amount);
        uint256 new_NFT_id = (_issue_id << 64) | new_editions_id;
        Edition storage new_NFT = editions_by_id[new_editions_id];
        new_NFT.NFT_id = new_NFT_id;
        new_NFT.transfer_price = 0;
        new_NFT.token_addr = address(0);
        new_NFT.is_on_sale = false;
        issues_by_id[_issue_id].remain_edition_amount -= 1;
        _setTokenURI(new_NFT_id, issues_by_id[_issue_id].ipfs_hash);
        _safeMint(msg.sender, new_NFT_id);
        return new_NFT_id;
    }

    /**
     * @dev Determine NFT price before transfer.
     *
     * Requirements:
     * 
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     *
     * Emits a {determinePriceSuccess} event, which contains:
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     */
    function determinePrice(
        uint256 _NFT_id, 
        address _token_addr,
        uint256 _price
    ) public {
        require(isEditionExist(_NFT_id), "royaltyNFT: The NFT you want to buy is not exist.");
        require(msg.sender == ownerOf(_NFT_id), "royaltyNFT: NFT's price should set by onwer of it.");
        require(issues_by_id[getIssueIdByNFTId(_NFT_id)].base_royaltyfee[_token_addr] != 0, "royaltyNFT: The token your selected is not supported.");
        if (_price < issues_by_id[getIssueIdByNFTId(_NFT_id)].base_royaltyfee[_token_addr])
            editions_by_id[_NFT_id].transfer_price = issues_by_id[getIssueIdByNFTId(_NFT_id)].base_royaltyfee[_token_addr];
        else 
            editions_by_id[_NFT_id].transfer_price = _price;
        editions_by_id[_NFT_id].token_addr = _token_addr;
        editions_by_id[_NFT_id].is_on_sale = true;
        emit determinePriceSuccess(_NFT_id, _token_addr, _price);
    }

    function determinePriceAndApprove(
        uint256 _NFT_id, 
        address _token_addr,
        uint256 _price,
        address _to
    ) public {
        determinePrice(_NFT_id, _token_addr, _price);
        approve(_to, _NFT_id);
    }
    
    function _afterTokenTransfer (
        uint256 _NFT_id
    ) internal {
        editions_by_id[_NFT_id].transfer_price = 0;
    }

    function transferFrom(
        address from, 
        address to, 
        uint256 NFT_id
    ) public payable override{
        require(_isApprovedOrOwner(_msgSender(), NFT_id), "royaltyNFT: transfer caller is not owner nor approved");
        require(isEditionExist(NFT_id), "royaltyNFT: Edition is not exist.");
        if (to != issues_by_id[getIssueIdByNFTId(NFT_id)].publisher && from != issues_by_id[getIssueIdByNFTId(NFT_id)].publisher) {
            require(editions_by_id[NFT_id].is_on_sale, "royaltyNFT: This NFT is not on sale.");
            uint256 royalty_fee = calculateRoyaltyFee(editions_by_id[NFT_id].transfer_price, issues_by_id[getIssueIdByNFTId(NFT_id)].royalty_fee);
            if (royalty_fee < issues_by_id[getIssueIdByNFTId(NFT_id)].base_royaltyfee[editions_by_id[NFT_id].token_addr]){
                royalty_fee = issues_by_id[getIssueIdByNFTId(NFT_id)].base_royaltyfee[editions_by_id[NFT_id].token_addr];
            }
            if (editions_by_id[NFT_id].token_addr == address(0)) {
                require(msg.value == editions_by_id[NFT_id].transfer_price, "royaltyNFT: not enought ETH");
                issues_by_id[getIssueIdByNFTId(NFT_id)].publisher.transfer(royalty_fee);
                payable(ownerOf(NFT_id)).transfer(editions_by_id[NFT_id].transfer_price.sub(royalty_fee));
            }
            else {
                IERC20(editions_by_id[NFT_id].token_addr).safeTransferFrom(msg.sender, issues_by_id[getIssueIdByNFTId(NFT_id)].publisher, royalty_fee);
                IERC20(editions_by_id[NFT_id].token_addr).safeTransferFrom(msg.sender, ownerOf(NFT_id), editions_by_id[NFT_id].transfer_price.sub(royalty_fee));
            }
        } 

        _transfer(from, to, NFT_id);
        _afterTokenTransfer(NFT_id);

    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 NFT_id
    ) public payable override{
      
        require(_isApprovedOrOwner(_msgSender(), NFT_id), "royaltyNFT: transfer caller is not owner nor approved");
        require(isEditionExist(NFT_id), "royaltyNFT: Edition is not exist.");
        if (to != issues_by_id[getIssueIdByNFTId(NFT_id)].publisher && from != issues_by_id[getIssueIdByNFTId(NFT_id)].publisher) {
            require(editions_by_id[NFT_id].is_on_sale, "royaltyNFT: This NFT is not on sale.");
            uint256 royalty_fee = calculateRoyaltyFee(editions_by_id[NFT_id].transfer_price, issues_by_id[getIssueIdByNFTId(NFT_id)].royalty_fee);
            if (royalty_fee < issues_by_id[getIssueIdByNFTId(NFT_id)].base_royaltyfee[editions_by_id[NFT_id].token_addr]){
                royalty_fee = issues_by_id[getIssueIdByNFTId(NFT_id)].base_royaltyfee[editions_by_id[NFT_id].token_addr];
            }
            // 如果大于存在一个改价的情况
            if (editions_by_id[NFT_id].token_addr == address(0)) {
                require(msg.value == editions_by_id[NFT_id].transfer_price, "royaltyNFT: not enought ETH");
                issues_by_id[getIssueIdByNFTId(NFT_id)].publisher.transfer(royalty_fee);
                payable(ownerOf(NFT_id)).transfer(editions_by_id[NFT_id].transfer_price.sub(royalty_fee));
            }
            else {
                IERC20(editions_by_id[NFT_id].token_addr).safeTransferFrom(msg.sender, issues_by_id[getIssueIdByNFTId(NFT_id)].publisher, royalty_fee);
                IERC20(editions_by_id[NFT_id].token_addr).safeTransferFrom(msg.sender, ownerOf(NFT_id), editions_by_id[NFT_id].transfer_price.sub(royalty_fee));
            }
        } 

        _safeTransfer(from, to, NFT_id, "");
        _afterTokenTransfer(NFT_id);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 NFT_id,
        bytes calldata _data
    ) public payable override {
        safeTransferFrom(from, to, NFT_id);
    }
    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        // Clear approvals from the previous owner
        _approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

     /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * `_data` is additional data, it has no specified format and it is sent in call to `to`.
     *
     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
     * implement alternative mechanisms to perform token transfer, such as signature-based.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _transfer(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    function calculateRoyaltyFee(uint256 _amount, uint8 _royalty_fee) private pure returns (uint256) {
        return _amount.mul(_royalty_fee).div(
            10**2
        );
    }
    
    function setRoyaltyPercent(uint64 _issue_id, uint8 _royalty_fee) external {
        require(_royalty_fee <= 100, "royaltyNFT: royalty fee can not exceed 100.");
        issues_by_id[_issue_id].royalty_fee = _royalty_fee;
    }

    /**
     * @dev Returns whether `spender` is allowed to manage `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Safely mints `tokenId` and transfers it to `to`.
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
     */
    function _safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _mint(to, tokenId);
        require(
            _checkOnERC721Received(address(0), to, tokenId, _data),
            "ERC721: transfer to non ERC721Receiver implementer"
        );
    }

    /**
     * @dev Mints `tokenId` and transfers it to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - `to` cannot be the zero address.
     *
     * Emits a {Transfer} event.
     */
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }


    /**
     * @dev Approve `to` to operate on `tokenId`
     *
     * Emits a {Approval} event.
     */
    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721: transfer to non ERC721Receiver implementer");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    } 
    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }
    function isIssueExist(uint192 _issue_id) public view returns (bool) {
        return (issues_by_id[_issue_id].issue_id != 0);
    }
    function isEditionExist(uint256 _NFT_id) public view returns (bool) {
        return (editions_by_id[_NFT_id].NFT_id != 0);
    }

    function getIssueIdByNFTId(uint256 _NFT_id) public pure returns (uint192) {
        return uint192(_NFT_id >> 64);
    }

    function getNFTIdByIssueId(uint192 _issue_id) public view returns (uint256 [] memory) {
        require(isIssueExist(_issue_id), "royaltyNFT: This issue is not exist.");
        uint256 [] memory NFT_ids = new uint256 [](issues_by_id[_issue_id].total_edition_amount);
        for (uint256 editions_id = 0; editions_id < issues_by_id[_issue_id].total_edition_amount; editions_id++){
            NFT_ids[editions_id] = uint256(_issue_id << 64 | editions_id);
        }
        return NFT_ids;
    }
    function getPublisherByIssueId(uint192 _issue_id) public view returns (address) {
        require(isIssueExist(_issue_id), "royaltyNFT: This issue is not exist.");
        return issues_by_id[_issue_id].publisher;
    }
    function getIssueNameByIssueId(uint192 _issue_id) public view returns (string memory) {
        require(isIssueExist(_issue_id), "royaltyNFT: This issue is not exist.");
        return issues_by_id[_issue_id].name;
    }
    function getRoyaltyFeeByIssueId(uint192 _issue_id) public view returns (uint8) {
        require(isIssueExist(_issue_id), "royaltyNFT: This issue is not exist.");
        return issues_by_id[_issue_id].royalty_fee;
    }
    function getPriceByNFTId(uint256 _NFT_id) public view returns (uint256) {
        require(isEditionExist(_NFT_id), "royaltyNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].transfer_price;
    }
    function getTokenaddrByNFTId(uint256 _NFT_id) public view returns (address) {
        require(isEditionExist(_NFT_id), "royaltyNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].token_addr;
    }

}


// File contracts/ShillNFT.sol



pragma solidity >= 0.8.0;











contract SparkNFT is Context, ERC165, IERC721, IERC721Metadata{
    using Address for address;
    using Counters for Counters.Counter;
    using SafeMath for uint256;
    Counters.Counter private _issueIds;
    // 由于时间关系先写中文注释
    // Issue 用于存储一系列的NFT，他们对应同一个URI，以及一系列相同的属性，在结构体中存储
    // 重要的有royalty_fee 用于存储手续费抽成比例
    // base_royaltyfee 当按照比例计算的手续费小于这个值的时候，取用这个值
    // 以这样的方式增大其传播性，同时使得上层的NFT具备价值
    // shill_times 代表这个issue中的一个NFT最多能够产出多少份子NFT
    // total_amount 这个issue总共产出了多少份NFT，同时用于新产出的NFT标号，标号从1开始
    // first_sell_price 规定了根节点的NFT mint 子节点的费用，之后所有的子节点mint出新节点的费用不会高于这个值
    struct Issue {
        // The publisher publishes a series of NFTs with the same content and different NFT_id each time.
        // This structure is used to store the public attributes of same series of NFTs.
        uint128 issue_id;
        // Number of NFTs have not been minted in this series
        uint8 royalty_fee;
        // Used to identify which series it is.
        // Publisher of this series NFTs
        uint64 shill_times;
        uint128 total_amount;
        string ipfs_hash;
        // Metadata json file.
        string name;
        // issue's name
        // List of tokens(address) can be accepted for payment.
        // And specify the min fee should be toke when series of NFTs are sold.
        // If base_royaltyfee[tokens] == 0, then this token will not be accepted.
        // `A token address` can be ERC-20 token contract address or `address(0)`(ETH).
        uint256 first_sell_price;
        // The price should be payed when this series NTFs are minted.
        // 这两个mapping如果存在token_addr看价格是不可以等于0的，如果等于0的话会导致判不支持
        // 由于这个价格是写死的，可能会诱导用户的付款倾向
    }
    // 存储NFT相关信息的结构体
    // father_id存储它父节点NFT的id
    // transfer_price 在决定出售的时候设定，买家调起transferFrom付款并转移
    // shillPrice存储从这个子节点mint出新的NFT的价格是多少
    // 此处可以优化，并不需要每一个节点都去存一个，只需要一层存一个就可以了，但是需要NFT_id调整编号的方式与节点在树上的位置强相关
    // is_on_sale 在卖家决定出售的时候将其设置成true，交易完成时回归false，出厂默认为false
    // remain_shill_times 记录该NFT剩余可以产生的NFT
    struct Edition {
        // Information used to decribe an NFT.
        uint256 NFT_id;
        uint256 father_id;
        // Index of this NFT.
        uint256 transfer_price;
        uint256 shillPrice;
        uint256 profit;
        // The price of the NFT in the transaction is determined before the transaction.
        bool is_on_sale;
        uint64 remain_shill_times;
        // royalty_fee for every transfer expect from or to exclude address, max is 100;
    }
    // 分别存储issue与editions
    mapping (uint256 => Issue) private issues_by_id;
    mapping (uint256 => Edition) private editions_by_id;
    // 去他妈的俄罗斯套娃mapping
    // 确定价格成功后的事件
    event DeterminePrice(
        uint256 indexed NFT_id,
        uint256 transfer_price
    );
    // 确定价格的同时approve买家可以操作owner的NFT
    event DeterminePriceAndApprove(
        uint256 indexed NFT_id,
        uint256 transfer_price,
        address indexed to
    );
    // 除上述变量外，该事件还返回根节点的NFTId
    event Publish(
	    uint128 indexed issue_id,
        address indexed publisher,
        uint256 rootNFTId,
        Issue issueData
    );
    // 子节点mint成功，加入了购买者和NFT_id的关系，可以配合transfer的log一起过滤获取某人的所有NFT_id
    event Mint (
        uint256 indexed NFT_id,
        uint256 indexed father_id,
        address indexed owner,
        Edition editionData
    );
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed NFT_id,
        uint256 transfer_price
    );
    // 获取自己的收益成功
    event Claim(
        uint256 indexed NFT_id,
        address indexed receiver,
        uint256 amount
    );
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;
    uint8 constant loss_ratio = 90;
    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;
    //----------------------------------------------------------------------------------------------------
    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor() {
        _name = "SparkNFT";
        _symbol = "SparkNFT";
    }
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOf(address owner) public view virtual override returns (uint256) {
        require(owner != address(0), "SparkNFT: balance query for the zero address");
        return _balances[owner];
    }

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "SparkNFT: owner query for nonexistent token");
        return owner;
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev See {IERC721-approve}.
     */
    function approve(address to, uint256 tokenId) public payable virtual override {
        address owner = ownerOf(tokenId);
        require(to != owner, "SparkNFT: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "SparkNFT: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

    /**
     * @dev See {IERC721-getApproved}.
     */
    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        require(_exists(tokenId), "SparkNFT: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev See {IERC721-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "SparkNFT: approve to caller");
        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC721-isApprovedForAll}.
     */
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function _baseURI() internal pure returns (string memory) {
        return "https://ipfs.io/ipfs/";
    } /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "SparkNFT: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();
        return string(abi.encodePacked(base, _tokenURI));
        
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "SparkNFT: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal {
        address owner = ownerOf(tokenId);
        // Clear approvals
        _approve(address(0), tokenId);

        _balances[owner] -= 1;
        delete _owners[tokenId];

        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }

        emit Transfer(owner, address(0), tokenId);
    }
    /**
     * @dev Determine NFT price before transfer.
     *
     * Requirements:
     * 
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     *
     * Emits a {DeterminePrice} event, which contains:
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     */
     // ？ 这个地方有个问题，按照这篇文章https://gus-tavo-guim.medium.com/public-vs-external-functions-in-solidity-b46bcf0ba3ac
     // 在external函数之中使用calldata进行传参数的gas消耗应该会更少一点
     // 但是大部分地方能看到的都是memory
     
    // publish函数分为这样几个部分
    // 首先检验传入的参数是否正确，是否出现了不符合逻辑的上溢现象
    // 然后获取issueid
    // 接下来调用私有函数去把对应的变量赋值
    // 初始化根节点NFT
    // 触发事件，将数据上到log中
    function publish(
        uint256 _first_sell_price,
        uint8 _royalty_fee,
        uint64 _shill_times,
        string memory _issue_name,
        string memory _ipfs_hash
    ) external {
        require(_royalty_fee <= 100, "SparkNFT: Royalty fee should less than 100.");
        _issueIds.increment();
        uint128 max_128 = type(uint128).max;
        uint64 max_64 = type(uint64).max;
        require(_shill_times <= max_64, "SparkNFT: Shill_times doesn't fit in 64 bits");
        require((_issueIds.current()) <= max_128, "SparkNFT: Issue id doesn't fit in 128 bits");
        uint128 new_issue_id = uint128(_issueIds.current());
        _publish(
            _issue_name, 
            new_issue_id,
            _shill_times, 
            _royalty_fee, 
            _first_sell_price, 
            _ipfs_hash
        );
        uint256 rootNFTId =  _initialRootEdition(new_issue_id);
        emit Publish(
            issues_by_id[new_issue_id].issue_id,
            msg.sender,
            rootNFTId,
            issues_by_id[new_issue_id]
        );
    }
    function _publish(
        string memory _issue_name,
        uint128 new_issue_id,
        uint64 _shill_times,
        uint8 _royalty_fee,
        uint256 _first_sell_price,
        string memory _ipfs_hash
    ) internal {
        Issue storage new_issue = issues_by_id[new_issue_id];
        new_issue.name = _issue_name;
        new_issue.issue_id = new_issue_id;
        new_issue.royalty_fee = _royalty_fee;
        new_issue.shill_times = _shill_times;
        new_issue.total_amount = 0;
        new_issue.ipfs_hash = _ipfs_hash;
        new_issue.first_sell_price = _first_sell_price;
    }

    function _initialRootEdition(uint128 _issue_id) internal returns (uint256) {
        issues_by_id[_issue_id].total_amount += 1;
        uint128 new_edition_id = issues_by_id[_issue_id].total_amount;
        uint256 new_NFT_id = getNftIdByEditionIdAndIssueId(_issue_id, new_edition_id);
        Edition storage new_NFT = editions_by_id[new_edition_id];
        new_NFT.NFT_id = new_NFT_id;
        new_NFT.transfer_price = 0;
        new_NFT.profit = 0;
        new_NFT.is_on_sale = false;
        new_NFT.father_id = 0;
        new_NFT.shillPrice = issues_by_id[_issue_id].first_sell_price;
        new_NFT.remain_shill_times = issues_by_id[_issue_id].shill_times;
        
        _setTokenURI(new_NFT_id, issues_by_id[_issue_id].ipfs_hash);
        _safeMint(msg.sender, new_NFT_id);
        emit Mint(
            new_NFT_id,
            0,
            msg.sender,
            new_NFT
        );
        return new_NFT_id;
    }
    // 由于存在loss ratio 我希望mint的时候始终按照比例收税
    // 接受shill的函数，也就是mint新的NFT
    // 传入参数是新的NFT的父节点的NFTid
    // 首先还是检查参数是否正确，同时加入判断以太坊是否够用的检测
    // 如果是根节点就不进行手续费扣款
    // 接下来mintNFT
    // 最后触发事件
    function accepetShill(
        uint256 _NFT_id
    ) public payable {
        require(isEditionExist(_NFT_id), "SparkNFT: This NFT is not exist.");
        require(editions_by_id[_NFT_id].remain_shill_times > 0, "SparkNFT: There is no remain shill times for this NFT.");
        require(msg.value == editions_by_id[_NFT_id].shillPrice, "SparkNFT: not enought ETH");
        _addProfit( _NFT_id, editions_by_id[_NFT_id].shillPrice);
        _mintNFT(_NFT_id, msg.sender);
        editions_by_id[_NFT_id].remain_shill_times -= 1;
        if (editions_by_id[_NFT_id].remain_shill_times == 0) {
            _mintNFT(_NFT_id, ownerOf(_NFT_id));
        }
    }

    function _mintNFT(
        uint256 _NFT_id,
        address _owner
    ) internal returns (uint256) {
        uint128 max_128 = type(uint128).max;
        uint128 _issue_id = getIssueIdByNFTId(_NFT_id);
        issues_by_id[_issue_id].total_amount += 1;
        require(issues_by_id[_issue_id].total_amount < max_128, "SparkNFT: There is no left in this issue.");
        uint128 new_edition_id = issues_by_id[_issue_id].total_amount;
        uint256 new_NFT_id = getNftIdByEditionIdAndIssueId(_issue_id, new_edition_id);
        Edition storage new_NFT = editions_by_id[new_edition_id];
        new_NFT.NFT_id = new_NFT_id;
        new_NFT.remain_shill_times = issues_by_id[_issue_id].shill_times;
        new_NFT.transfer_price = 0;
        new_NFT.father_id = _NFT_id;
        new_NFT.shillPrice = editions_by_id[_NFT_id].shillPrice - calculateFee(editions_by_id[_NFT_id].shillPrice, loss_ratio);
        new_NFT.is_on_sale = false;
        new_NFT.profit = 0;
        _setTokenURI(new_NFT_id, issues_by_id[_issue_id].ipfs_hash);
        _safeMint(_owner, new_NFT_id);
        emit Mint(
            new_NFT_id,
            _NFT_id,
            _owner,
            new_NFT
        );
        return new_NFT_id;
    }

    /**
     * @dev Determine NFT price before transfer.
     *
     * Requirements:
     * 
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     *
     * Emits a {DeterminePrice} event, which contains:
     * - `_NFT_id` transferred token id.
     * - `_token_addr` address of the token this transcation used, address(0) represent ETH.
     * - `_price` The amount of `_token_addr` should be payed for `_NFT_id`
     */
    function determinePrice(
        uint256 _NFT_id,
        uint256 _price
    ) public {
        require(isEditionExist(_NFT_id), "SparkNFT: The NFT you want to buy is not exist.");
        require(msg.sender == ownerOf(_NFT_id), "SparkNFT: NFT's price should set by onwer of it.");
        editions_by_id[_NFT_id].transfer_price = _price;
        editions_by_id[_NFT_id].is_on_sale = true;
        emit DeterminePrice(_NFT_id, _price);
    }

    function determinePriceAndApprove(
        uint256 _NFT_id,
        uint256 _price,
        address _to
    ) public {
        determinePrice(_NFT_id, _price);
        approve(_to, _NFT_id);
    }
    // 将flag在转移后重新设置
    function _afterTokenTransfer (
        uint256 _NFT_id
    ) internal {
        editions_by_id[_NFT_id].transfer_price = 0;
        editions_by_id[_NFT_id].is_on_sale = false;
    }
    // 加入一个owner调取transfer不需要check是否onsale
    function transferFrom(
        address from, 
        address to, 
        uint256 NFT_id
    ) public payable override{
        require(_isApprovedOrOwner(_msgSender(), NFT_id), "SparkNFT: transfer caller is not owner nor approved");
        require(isEditionExist(NFT_id), "SparkNFT: Edition is not exist.");
        require(editions_by_id[NFT_id].is_on_sale, "SparkNFT: This NFT is not on sale.");
        require(msg.value == editions_by_id[NFT_id].transfer_price, "SparkNFT: not enought ETH");
        _addProfit(NFT_id, editions_by_id[NFT_id].transfer_price);
        claimProfit(NFT_id);
        _transfer(from, to, NFT_id);
        _afterTokenTransfer(NFT_id);

    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 NFT_id
    ) public payable override{
        require(_isApprovedOrOwner(_msgSender(), NFT_id), "SparkNFT: transfer caller is not owner nor approved");
        require(isEditionExist(NFT_id), "SparkNFT: Edition is not exist.");
        require(editions_by_id[NFT_id].is_on_sale, "SparkNFT: This NFT is not on sale.");
        require(msg.value == editions_by_id[NFT_id].transfer_price, "SparkNFT: not enought ETH");
        _addProfit(NFT_id, editions_by_id[NFT_id].transfer_price);
        claimProfit(NFT_id);
        _safeTransfer(from, to, NFT_id, "");
        _afterTokenTransfer(NFT_id);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 NFT_id,
        bytes calldata _data
    ) public payable override {
        safeTransferFrom(from, to, NFT_id);
    }
    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        require(ownerOf(tokenId) == from, "SparkNFT: transfer of token that is not own");
        require(to != address(0), "SparkNFT: transfer to the zero address");

        // Clear approvals from the previous owner
        _approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }
    function claimProfit(uint256 _NFT_id) public {
        require(editions_by_id[_NFT_id].profit > 0, "SparkNFT: There is no profit to be claimed.");
        uint256 amount = editions_by_id[_NFT_id].profit;
        editions_by_id[_NFT_id].profit = 0;
        if (getFatherByNFTId(_NFT_id) != 0) {
            uint256 _royalty_fee = calculateFee(editions_by_id[_NFT_id].profit, issues_by_id[getIssueIdByNFTId(_NFT_id)].royalty_fee);
            _addProfit( getFatherByNFTId(_NFT_id), _royalty_fee);
            amount.sub(_royalty_fee);
        }
        payable(ownerOf(_NFT_id)).transfer(amount);
        emit Claim(
            _NFT_id,
            ownerOf(_NFT_id),
            amount
        );
    }
     /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * `_data` is additional data, it has no specified format and it is sent in call to `to`.
     *
     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
     * implement alternative mechanisms to perform token transfer, such as signature-based.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _transfer(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "SparkNFT: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether `spender` is allowed to manage `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        require(_exists(tokenId), "SparkNFT: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Safely mints `tokenId` and transfers it to `to`.
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
     */
    function _safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _mint(to, tokenId);
        require(
            _checkOnERC721Received(address(0), to, tokenId, _data),
            "SparkNFT: transfer to non ERC721Receiver implementer"
        );
    }

    /**
     * @dev Mints `tokenId` and transfers it to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - `to` cannot be the zero address.
     *
     * Emits a {Transfer} event.
     */
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "SparkNFT: mint to the zero address");
        require(!_exists(tokenId), "SparkNFT: token already minted");

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }


    /**
     * @dev Approve `to` to operate on `tokenId`
     *
     * Emits a {Approval} event.
     */
    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("SparkNFT: transfer to non ERC721Receiver implementer");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    } 
    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */

    function calculateFee(uint256 _amount, uint8 _fee_percent) internal pure returns (uint256) {
        return _amount.mul(_fee_percent).div(
            10**2
        );
    }
    function getNftIdByEditionIdAndIssueId(uint128 _issue_id, uint128 _edition_id) internal pure returns (uint256) {
        return (uint256(_issue_id)<<128)|uint256(_edition_id);
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }



    function getLossRatio() public pure returns (uint8) {
        return loss_ratio;
    }
    function _addProfit(uint256 _NFT_id, uint256 _increase) internal {
        editions_by_id[_NFT_id].profit = editions_by_id[_NFT_id].profit.add(_increase);
    }
    function _subProfit(uint256 _NFT_id, uint256 _decrease) internal {
        editions_by_id[_NFT_id].profit = editions_by_id[_NFT_id].profit.sub(_decrease);
    }

    function isIssueExist(uint128 _issue_id) public view returns (bool) {
        return (issues_by_id[_issue_id].issue_id != 0);
    }
    function isEditionExist(uint256 _NFT_id) public view returns (bool) {
        return (editions_by_id[_NFT_id].NFT_id != 0);
    }

    function getIssueIdByNFTId(uint256 _NFT_id) public pure returns (uint128) {
        return uint128(_NFT_id >> 128);
    }

    function getIssueNameByIssueId(uint128 _issue_id) public view returns (string memory) {
        require(isIssueExist(_issue_id), "SparkNFT: This issue is not exist.");
        return issues_by_id[_issue_id].name;
    }
    function getIpfsHashByIssueId(uint128 _issue_id) public view returns (string memory) {
        require(isIssueExist(_issue_id), "SparkNFT: This issue is not exist.");
        return issues_by_id[_issue_id].ipfs_hash;
    }
    function getRoyaltyFeeByIssueId(uint128 _issue_id) public view returns (uint8) {
        require(isIssueExist(_issue_id), "SparkNFT: This issue is not exist.");
        return issues_by_id[_issue_id].royalty_fee;
    }
    function getShellTimesByIssyeId(uint128 _issue_id) public view returns (uint64) {
        require(isIssueExist(_issue_id), "SparkNFT: This issue is not exist.");
        return issues_by_id[_issue_id].shill_times;
    }
    function getTotalAmountByIssueId(uint128 _issue_id) public view returns (uint128) {
        require(isIssueExist(_issue_id), "SparkNFT: This issue is not exist.");
        return issues_by_id[_issue_id].total_amount;
    }
    function getFatherByNFTId(uint256 _NFT_id) public view returns (uint256) {
        require(isEditionExist(_NFT_id), "SparkNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].father_id;
    }
    function getTransferPriceByNFTId(uint256 _NFT_id) public view returns (uint256) {
        require(isEditionExist(_NFT_id), "SparkNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].transfer_price;
    }
    function getShillPriceByNFTId(uint256 _NFT_id) public view returns (uint256) {
        require(isEditionExist(_NFT_id), "SparkNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].shillPrice;
    }
    function getRemainShillTimesByNFTId(uint256 _NFT_id) public view returns (uint64) {
        require(isEditionExist(_NFT_id), "SparkNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].remain_shill_times;
    }
    function isNFTOnSale(uint256 _NFT_id) public view returns (bool) {
        require(isEditionExist(_NFT_id), "SparkNFT: Edition is not exist.");
        return editions_by_id[_NFT_id].is_on_sale;
    }
}