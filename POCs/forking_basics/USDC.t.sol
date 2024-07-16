// assuming file is inside the foundry initialized directory,
// run this command := forge test --contracts test/USDC.t.sol -vvv
import "forge-std/Test.sol";

interface IERC20 {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function withdraw(uint256 wad) external;

    function deposit(uint256 wad) external returns (bool);

    function owner() external view returns (address);
}

contract ContractTest is Test {
    function setUp() external {
        // vm.createSelectFork("https://rpc.ankr.com/eth", 15_941_703);
    }

    function test_USDCTotalSupplyOnMainnet() public {
        IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        vm.createSelectFork("https://rpc.ankr.com/eth", 15_941_703);
        console.log("network: Eth_mainnet");
        console.log("block number: ", block.number);
        console.log("totalSupply of USDC: ", USDC.totalSupply());
    }

    function test_USDCTotalSupplyOnBinance() public {
        IERC20 USDC = IERC20(0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d);
        vm.createSelectFork("https://rpc.ankr.com/bsc", 16_941_999);
        console.log("network: BSC");
        console.log("block number: ", block.number);
        console.log("totalSupply of USDC: ", USDC.totalSupply());
    }

    function test_USDCTotalSupplyOnPolygon() public {
        IERC20 USDC = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);

        vm.createSelectFork("https://rpc.ankr.com/polygon", 16_941_999);

        console.log("network: MATIC");
        console.log("block number: ", block.number);
        console.log("totalSupply of USDC: ", USDC.totalSupply());
    }

    function test_Dealing_USDC_n_Eth_To_Alice_On_Mainnet() public {
        IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

        vm.createSelectFork("https://rpc.ankr.com/eth", 15_941_703);
        console.log("network: Eth_mainnet");
        console.log("block number: ", block.number);
        address alice = makeAddr("alice");
        deal(address(USDC), alice, 1000); // dealing 1000 USDC to alice
        deal(alice, 11); // dealing 11 ETH to alice

        console.log("alice's USDC balance: ", USDC.balanceOf(alice));
        console.log("alice's ETH balance:", alice.balance);
    }

    function test_Setting_networkForkAcrosstheTest() public {
        console.log(
            "vm.createSelectFork := it is used for setting up the fork of specific network at specific blocknumber."
        );
        console.log(" it takes two params: ");
        console.log(
            "1) network rpc := which you can get from `https://github.com/burhankhaja/Post_Morterms/blob/main/POCs/rpc_endpoints%20/foundry.toml`"
        );
        console.log(
            " 2) blocknumber := the block number you want to replicate the tx on"
        );
        console.log(
            "Note: right now i have commented out the general forking setup, because i want to create test for different networks and for that in each test i will fork different networks on same or different blocknumber"
        );
        console.log(
            "AAaaaaaand Dont forget on different networks even on l2's USDC token address is different, usage of mainnet one will result in revert as the contract doesnt exist at the destination"
        );
    }

    function test_Dealing_NativeCurrency() public {
        console.log(
            "for dealing the native currency to any address on the specific network, use deal(to, amount) => on eth it will give out ETH, similarly on polygon it will deal MATIC etc etc"
        );
    }
}
