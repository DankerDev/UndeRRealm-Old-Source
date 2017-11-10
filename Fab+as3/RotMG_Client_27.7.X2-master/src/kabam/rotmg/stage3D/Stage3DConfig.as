package kabam.rotmg.stage3D
{
import robotlegs.bender.framework.api.IConfig;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.StageProxy;
import org.swiftsuspenders.Injector;
import com.company.assembleegameclient.util.Stage3DProxy;
import flash.events.ErrorEvent;
import flash.events.Event;
import kabam.rotmg.stage3D.graphic3D.TextureFactory;
import kabam.rotmg.stage3D.graphic3D.IndexBufferFactory;
import kabam.rotmg.stage3D.graphic3D.VertexBufferFactory;
import kabam.rotmg.stage3D.proxies.Context3DProxy;
import flash.display3D.Context3DBlendFactor;
import flash.display3D.Context3DCompareMode;
import kabam.rotmg.stage3D.graphic3D.Graphic3DHelper;
import com.company.assembleegameclient.engine3d.Model3D;

public class Stage3DConfig implements IConfig
{

    public static var WIDTH:int = 600;

    public static var HALF_WIDTH:int = WIDTH / 2;

    public static var HEIGHT:int = 600;

    public static var HALF_HEIGHT:int = HEIGHT / 2;


    [Inject]
    public var stageProxy:StageProxy;

    [Inject]
    public var injector:Injector;

    public var renderer:kabam.rotmg.stage3D.Renderer;

    private var stage3D:Stage3DProxy;

    public function Stage3DConfig()
    {
        super();
    }

    public static function resetDimensions() : void
    {
        var _local1:Number = Parameters.data_["mscale"];
        var _local2:Number = WebMain.sWidth / _local1;
        var _local3:Number = WebMain.sHeight / _local1;
        WIDTH = _local2;
        HALF_WIDTH = _local2 / 2;
        HEIGHT = _local3;
        HALF_HEIGHT = _local3 / 2;
    }

    public function configure() : void
    {
        this.mapSingletons();
        this.stage3D = this.stageProxy.getStage3Ds(0);
        this.stage3D.addEventListener(ErrorEvent.ERROR,Parameters.clearGpuRenderEvent);
        this.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreate);
        this.stage3D.requestContext3D();
    }

    private function mapSingletons() : void
    {
        this.injector.map(Render3D).asSingleton();
        this.injector.map(TextureFactory).asSingleton();
        this.injector.map(IndexBufferFactory).asSingleton();
        this.injector.map(VertexBufferFactory).asSingleton();
    }

    private function onContextCreate(param1:Event) : void
    {
        this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreate);
        var _local2:Context3DProxy = this.stage3D.getContext3D();
        if(_local2.GetContext3D().driverInfo.toLowerCase().indexOf("software") != -1)
        {
            Parameters.clearGpuRender();
        }
        _local2.configureBackBuffer(WIDTH,HEIGHT,2,true);
        _local2.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
        _local2.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
        this.injector.map(Context3DProxy).toValue(_local2);
        Graphic3DHelper.map(this.injector);
        this.renderer = this.injector.getInstance(Renderer);
        this.renderer.init(_local2.GetContext3D());
        Model3D.Create3dBuffer(_local2.GetContext3D());
    }
}
}
